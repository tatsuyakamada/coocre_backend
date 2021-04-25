module ControllerSpecHelper
  extend ActiveSupport::Concern

  included do
    let(:response_body) do
      parsed = JSON.parse(response.body)
      parsed.is_a?(Array) ? parsed.map(&:deep_symbolize_keys) : parsed.deep_symbolize_keys
    end

    shared_examples 'invalid parameter' do
      it { expect(response).to have_http_status(:bad_request) }
    end

    shared_examples 'not found record' do
      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
