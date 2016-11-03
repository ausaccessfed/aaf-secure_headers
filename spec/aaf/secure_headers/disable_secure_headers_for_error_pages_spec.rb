# frozen_string_literal: true

RSpec.describe AAF::SecureHeaders::DisableSecureHeadersForErrorPages do
  let(:app) { ->(e) { response } }
  let(:env) { {} }
  subject { described_class.new(app) }

  def run
    subject.call(env)
  end

  shared_context 'a normal response' do
    it 'leaves the secure headers intact' do
      expect(SecureHeaders).not_to receive(:opt_out_of_all_protection)
      run
    end

    it 'returns the response' do
      expect(run).to eq(response)
    end
  end

  shared_context 'an error response' do
    it 'opts out of the secure headers' do
      expect(SecureHeaders).to receive(:opt_out_of_all_protection)
        .with(an_instance_of(ActionDispatch::Request))

      run
    end

    it 'returns the response' do
      expect(run).to eq(response)
    end
  end

  context 'when the response is successful' do
    let(:response) { [200, { 'Content-Type' => 'text/plain' }, ['hi there']] }
    it_behaves_like 'a normal response'
  end

  context 'when the response is a redirect' do
    let(:response) { [303, { 'Location' => '/other' }, []] }
    it_behaves_like 'a normal response'
  end

  context 'when the response is a 4xx error' do
    let(:response) { [404, {}, ['Not here']] }
    it_behaves_like 'an error response'
  end

  context 'when the response is a 5xx error' do
    let(:response) { [500, {}, ['Oops. Something broke']] }
    it_behaves_like 'an error response'
  end
end
