require_relative 'monroe'       # loads custom framework - monroe
require_relative 'advice'       # loads advice.rb

class App < Monroe              # inherits from class Monroe in monroe.rb
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      status = '200'
      headers = {'Content-Type' => 'text/html'}
      response(status, headers) do
        erb :index
      end
    when '/advice'
      piece_of_advice = Advice.new.generate
      status = '200'
      headers = {'Content-Type' => 'text/html'}
      response(status, headers) do
        erb :advice, message: piece_of_advice
      end
    else
      status = '400'
      headers = {'Content-Type' => 'text/html', 'Content-Length' => '60'}
      response(status, headers) do
        erb :not_found
      end
    end
  end
end

# OLD call method
# def call(env)
  #   case env['REQUEST_PATH']
  #   when '/'
  #     ['200', {'Content-Type' => 'text/html'}, [erb(:index)]]
  #   when '/advice'
  #     piece_of_advice = Advice.new.generate       # generates random piece of advice
  #     [
  #       '200',
  #       {'Content-Type' => 'text/html'},
  #       [erb(:advice, message: piece_of_advice)]
  #     ]
  #   else
  #     [
  #       '400',
  #       {'Content-Type' => 'text/html', 'Content-Length' => '60'},
  #       [erb(:not_found)]
  #     ]
  #   end
  # end


