package body;

public class ServerResponseContent {

    private StringBuilder responseHeader;
    private StringBuilder responseBody;
    private boolean isTypeSet;
    private boolean isBodySet;

    public ServerResponseContent() {

        this.responseHeader = new StringBuilder();
        isBodySet = false;
        isTypeSet = false;
    }

    public ServerResponseContent setType(ServerResponseType type) {
        if (!isTypeSet) {
            responseHeader.append(type.toString());
            isTypeSet = true;
        } else throw new IllegalStateException("Trying to set type to response with type set");
        return this;
    }

    public ServerResponseContent addProperty(ServerResponseProperty property) {
        if (!isBodySet) {
            responseHeader.append(property.toString());
        } else throw new IllegalStateException("Trying to add property to response with body set");
        return this;

    }

    public String getString() {
        StringBuilder fullResponse = new StringBuilder();
        fullResponse.append(responseHeader.toString().substring(0, responseHeader.length() - 1));
        if (responseBody != null && responseBody.length() != 0) {
            String contentLength = "\r\nContent-Length: " + responseBody.toString().getBytes().length + "";
            fullResponse.append(contentLength);
        }
        fullResponse.append("\r\n\r\n");
        if (responseBody != null && responseBody.length() != 0) {
            fullResponse.append(responseBody);
        }
        return fullResponse.toString();
    }

    public ServerResponseContent addBody(String bodyContent) {
        if (!isTypeSet) {
            throw new IllegalStateException("Trying to add body to response without type set");
        }
        if (responseBody == null) {
            responseBody = new StringBuilder();
        }
        responseBody.append(bodyContent);
        isBodySet = true;
        return this;
    }

}
