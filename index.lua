--// Dependancies
    Socket = require("socket")

--// variables
    --// server variables
        local PORT = 8080;
        local BACKLOG = 5;

--// server
    --// create TCP socket && bind to localhost
        local server = assert(Socket.tcp())
        assert(server:bind("*", PORT))
        server:listen(BACKLOG)

    --// print IP && port
        local ip, port = server:getsockname()
        print("Listening on IP=" .. ip .. ", PORT=" .. port .."...")
        
    --// loop

        while 1 do
            --.. wait for connection

            local client, err = server:accept()

            if client then
                local line, err = client:receive()
                -- .. send back

                if not err then
                    --.. header not plaintext

                    client:send("<pre>HTTP/1.0 200 OK!</pre>")
                else
                    client:send("<pre>HTTP/1.0 400 Bad Request!</pre>")
                end
            else
                print("Error occured wen connection\nError: " .. err)
            end

            --.. close connection
            client:close()
            print('end of connection')
        end

