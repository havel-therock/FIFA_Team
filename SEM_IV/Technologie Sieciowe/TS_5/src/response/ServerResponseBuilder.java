package response;

import server.ServerRequest;

public class ServerResponseBuilder {

    private String response;

    public ServerResponseBuilder(ServerRequest request) {

        ServerResponse builtResponse;
        if (!request.isValid()) {
            builtResponse = new ServerResponseInvalid();
            response = builtResponse.get();
            return;
        }


        switch (request.getRequestType()) {
            case "HEAD":
                builtResponse = new ServerResponseHEAD();
                break;
            case "GET":
                builtResponse = new ServerResponseGET(request);
                break;
            case "CLIENT":
                builtResponse = new ServerResponseCLIENT(request);
                break;
            default:
                throw new IllegalStateException("Unable to create response");

        }
        response = builtResponse.get();
    }

    public String buildResponse() {
        return response;
    }
}
