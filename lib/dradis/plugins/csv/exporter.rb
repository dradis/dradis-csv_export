module Dradis::Plugins::CSV
  class Exporter < Dradis::Plugins::Export::Base
    def export(args={})
      issues = content_service.all_issues

      if issues.empty?
        return "The project didn't contain any issues"
      else
        # All fields from all Issues in the project
        issue_keys    = issues.map(&:fields).map(&:keys).flatten.uniq

        # All fields from all Evidence in the project
        evidence_keys = issues.map do |issue|
          if issue.evidence.any?
            issue.evidence.map(&:fields).map(&:keys).flatten.uniq
          else
            []
          end
        end.flatten.uniq

        keys = issue_keys + evidence_keys

        issue_row    = []
        evidence_row = []

        # Create the CSV data
        csv_string = ::CSV.generate do |csv|

          # Add the header line with all the field names. Remember note.field returns
          # a hash: {'Title' => 'Foo', 'Description' => 'Bar'}
          csv << keys

          # For each of the notes in our category, we dump the field values.
          # This assumes all notes have the same fields, in the same order
          issues.each do |issue|
            issue_row = issue_keys.map do |key|
              issue.fields.fetch(key, 'n/a')
            end

            # If we've got multiple Evidence, we add one row per Evidence
            if issue.evidence.any?
              issue.evidence.each do |evidence|
                evidence_row = evidence_keys.map do |key|
                  evidence.fields.fetch(key, 'n/a')
                end

                csv << issue_row + evidence_row
              end
            else
              csv << issue_row
            end
          end
        end

        csv_string
      end

    end
  end
end
