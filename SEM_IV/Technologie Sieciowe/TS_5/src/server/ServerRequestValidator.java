package server;

public class ServerRequestValidator {

    boolean validate(ServerRequest serverRequest) {
        String request = serverRequest.getRequest();

        try {
            serverRequest.setRequestType(request.substring(0, request.indexOf(" ")));
        } catch (IndexOutOfBoundsException e) {
            ServerLogger.log("Request type format invalid");
            return false;
        }

        switch (serverRequest.getRequestType()) {
            case "GET":
            case "HEAD":
                return validateMethod(serverRequest);
            case "CLIENT":
                return true;
            default:
                return false;
        }
    }

    private boolean validateMethod(ServerRequest serverRequest) {

        String requestType = serverRequest.getRequestType();

        String requestTypeProperties[] = serverRequest.getParameter(requestType).split("\\s", 2);

        try {
            String HTTPVersion = requestTypeProperties[1];
            switch (HTTPVersion) {
                case "HTTP/1.0":
                    return true;
                case "HTTP/1.1":
                    return serverRequest.getParameter("Host") != null;
                default:
                    return false;
            }
        } catch (IndexOutOfBoundsException e) {
            ServerLogger.log("Request type properties invalid");
            return false;
        }

    }
}
