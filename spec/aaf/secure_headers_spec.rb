RSpec.describe AAF::SecureHeaders do
  it 'has a version number' do
    expect(AAF::SecureHeaders::VERSION).not_to be nil
  end

  describe '::development_mode!' do
    let(:middleware) { spy }
    let(:csp_config) { spy(Hash) }

    let(:secure_headers_config) do
      spy(SecureHeaders::Configuration, csp: csp_config)
    end

    before do
      allow(Rails).to receive_message_chain(:application, :config, :middleware)
        .and_return(middleware)

      allow(SecureHeaders::Configuration).to receive(:override)
        .with(:default).and_yield(secure_headers_config)
    end

    def run
      subject.development_mode!
    end

    it 'raises an exception when Rails is undefined' do
      expect(subject).to receive(:const_defined?)
        .with('Rails').and_return(false)

      expect { run }.to raise_error(/The Rails class is not defined/)
    end

    it 'includes the middleware' do
      run

      expect(middleware).to have_received(:insert_after)
        .with(SecureHeaders::Middleware,
              AAF::SecureHeaders::DisableSecureHeadersForErrorPages)
    end

    it 'overrides the defaults' do
      run

      expect(secure_headers_config).to have_received(:hsts=).with(nil)
      expect(csp_config).to have_received(:[]=)
        .with(:upgrade_insecure_requests, false)
    end
  end
end
