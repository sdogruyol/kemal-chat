require "kemal"

SOCKETS = [] of HTTP::WebSocketHandler::WebSocketSession

get "/" do
  render "views/index.ecr"
end

ws "/chat" do |socket|
  SOCKETS << socket
  socket.on_message do |message|
    SOCKETS.each { |socket| socket.send message}
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end
