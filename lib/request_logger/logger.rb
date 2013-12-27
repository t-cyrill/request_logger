module RequestLogger
  class Logger
    def filter(hash)
      hash.inject({}) {|result, (key, value)|
        value = filter(value) if Hash.try_convert(value)
        value = @filter_parameters.include?(key.to_sym) ? "[FILTERED]" : value

        if value.respond_to? "bytesize"
          value  = value.bytesize > @size_limit ? "[FILTERED Too Large (%d byte)] %s ..." % [value.bytesize, value[0, @filtered_limit]] : value
        end

        result[key] = value
        result
      }
    end

    def log(req)
      hash = {
        request_method: req.request_method,
        ip:             req.ip,
        host:           req.host,
        url:            req.url,
        cookies:        filter(req.cookies),
        user_agent:     req.user_agent,
        params:         filter(req.params),
        referer:        req.referer,
      }

      @logger.info(hash)
    end

    def initialize(app, logger, size_limit = 128, filtered_limit = 10)
      @app, @logger, @size_limit, @filtered_limit  = app, logger, size_limit, filtered_limit
    end

    def call(env)
      @filter_parameters = env["action_dispatch.parameter_filter"];
      log(Rack::Request.new(env))
      @app.call(env)
    end
  end
end
