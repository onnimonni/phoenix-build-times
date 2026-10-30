# Edits the login LiveView on request, so a browser benchmark can time the
# save -> screen update latency:
#
#   GET http://127.0.0.1:4999/edit/<marker>  puts <marker> into the page title
#   GET http://127.0.0.1:4999/restore        restores the file
#
#   elixir bench/hot-reload/editor.exs [app dir]
app = List.first(System.argv(), "shop")
file = Path.expand(Path.join(app, "lib/shop_web/live/user_live/login.ex"))
orig = File.read!(file)
{:ok, listen} = :gen_tcp.listen(4999, [:binary, active: false, reuseaddr: true, packet: :http_bin])
IO.puts("editing #{file} on http://127.0.0.1:4999")

serve = fn serve ->
  {:ok, socket} = :gen_tcp.accept(listen)
  {:ok, {:http_request, _, {:abs_path, path}, _}} = :gen_tcp.recv(socket, 0)

  case String.split(path, "/", trim: true) do
    ["edit", marker] -> File.write!(file, String.replace(orig, "<p>Log in</p>", "<p>Log in #{marker}</p>"))
    _ -> File.write!(file, orig)
  end

  :gen_tcp.send(socket, "HTTP/1.1 200 OK\r\ncontent-length: 2\r\nconnection: close\r\n\r\nok")
  :gen_tcp.close(socket)
  serve.(serve)
end

serve.(serve)
