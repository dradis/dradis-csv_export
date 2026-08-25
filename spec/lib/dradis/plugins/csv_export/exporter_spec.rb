# Run the spec in CE/Pro context with:
# rspec <relative path to dradis-csv_export>/spec/lib/dradis/plugins/csv_export/exporter_spec.rb

require 'rails_helper'

describe Dradis::Plugins::CSVExport::Exporter do
  let(:project) { create(:project) }
  let(:exporter) { described_class.new(project_id: project.id, scope: scope) }

  context 'when the project has no issues' do
    let(:scope) { :published }

    it "returns a message saying the project didn't contain any issues" do
      expect(exporter.export).to eq("The project didn't contain any issues")
    end
  end

  context 'evidence scope' do
    let(:node) { create(:node, project: project) }
    let!(:issue) { create(:issue, node: project.issue_library, state: :published) }
    let!(:published_evidence) do
      create(:evidence, issue: issue, node: node, state: :published, content: "#[EvidenceField]#\nPublished evidence\n")
    end
    let!(:draft_evidence) do
      create(:evidence, issue: issue, node: node, state: :draft, content: "#[EvidenceField]#\nDraft evidence\n")
    end

    context 'published scope' do
      let(:scope) { :published }

      it 'only includes published evidence' do
        csv = exporter.export

        expect(csv).to include('Published evidence')
        expect(csv).not_to include('Draft evidence')
      end
    end

    context 'all scope' do
      let(:scope) { :all }

      it 'includes evidence regardless of state' do
        csv = exporter.export

        expect(csv).to include('Published evidence')
        expect(csv).to include('Draft evidence')
      end
    end
  end
end
