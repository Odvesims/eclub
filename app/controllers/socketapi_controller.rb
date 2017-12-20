require 'json'
require 'net/http'
require 'socket'

class SocketapiController < ActionController::Base
	respond_to :json
    def index
        start_char = "@"
        divider_char = "|"
        end_char = "?"
        socket_port = params[:socket_port].to_i
        option = params[:option].to_s
        request_str = params[:request_str].to_s
        begin
            s = TCPSocket.new 'localhost', socket_port
            s.puts start_char + option + request_str + end_char
            @reply = ""
            while line = s.gets # Read lines from socket
                @reply +=  line
            end
            valid = true
            code = 200
            option = option
            data = @reply
            if option == '04'
                #s.puts "@TOK?"
            end
            s.close
        rescue Timeout::Error, Errno::EINVAL, Errno::ECONNREFUSED, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::Protocol$
            @reply = 'Network failure'
            valid = false
            code = 500
            option = option
            data = ''
        end
        el_jason = Array.new
        socket_reply = {}
        socket_reply["valid"] = valid
        socket_reply["code"] = code
        socket_reply["option"] = option
        socket_reply["data"] = data
        el_jason.push(socket_reply)
        JSON.generate(socket_reply)
        render :text => JSON.generate(socket_reply)
    end
end

