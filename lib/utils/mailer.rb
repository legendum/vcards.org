module VCards
  class Mailer

    SMTP_DEFAULT_HOST = 'localhost'
    SMTP_DEFAULT_PORT = 1025

    # We use Mail and MailCatcher in development and test modes
    # See delivered messages at http://localhost:1080/
    Mail.defaults do
      delivery_method :smtp, address: SMTP_DEFAULT_HOST, port: SMTP_DEFAULT_PORT
    end

    def self.parse_erb_file(path, params={})
      assert File.exist?(path), "file at \"#{path}\" doesn't exist"
      content = File.read(path)     
      ERB.new(content, 0, '-').result(DataStruct.new(params).instance_eval { binding })
    end

    def self.parse_css_html(html)
      document = Roadie::Document.new(html)
      document.asset_providers = [
        Roadie::FilesystemProvider.new("#{VCards::App.root}/app/public")
      ]
      document.transform
    end

    # Send an email message
    # @param Hash opts (with :from, :to, :subject, :text, :html string values)
    # @yield Hash params for parameters to include in the HTML and text copy
    def self.send(opts, params={})
      opts.symbolize_keys!
      brand = opts[:brand] || VCards.brands.default
      opts[:from] ||= VCards.email_address(:sender, brand)
      layout = "layouts/#{brand}/" + (opts[:layout] || 'default')
      params.symbolize_keys!
      if opts[:mail]
        layout_path = "../../mail/#{layout}"
        file_path = "../../mail/#{opts[:mail]}"
        files = ["#{layout_path}.text.erb", "#{layout_path}.html.erb"]
        files += ["#{file_path}.text.erb",  "#{file_path}.html.erb"]
        text_layout, html_layout, text_file, html_file = files.map do |file|
          File.expand_path(file, __FILE__)
        end
        opts[:text] = parse_erb_file(text_layout, params) do
          parse_erb_file(text_file, params)
        end
        opts[:html] = parse_erb_file(html_layout, params) do
          parse_erb_file(html_file, params)
        end
        opts[:html] = parse_css_html(opts[:html])
      end
      if VCards.production? || VCards.test?
        VCards.mailgun.messages.send_email(opts) # simple huh? :-)
      elsif VCards.development?
        Mail.deliver do
          from    opts[:from]
          to      opts[:to]
          subject opts[:subject]
          text_part do
            body  opts[:text]
          end if  opts[:text]
          html_part do
            content_type 'text/html; charset=UTF-8'
            body  opts[:html]
          end if  opts[:html]
        end
      else
        notify_and_abort "environment set to \"#{VCards.environment}\""
      end
    end
  end

  def self.mailer
    Mailer
  end
end
