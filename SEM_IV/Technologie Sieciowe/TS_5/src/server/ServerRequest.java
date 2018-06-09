package server;

import response.ServerResponseBuilder;

import java.util.HashMap;
import java.util.Map;


public class ServerRequest {

    private String request;
    private boolean valid;
    private String requestType;
    private Map<String, String> requestParameters;

    ServerRequest(String request) {
        this.request = request;
        requestParameters = new HashMap<>();
        parseParameters();
        validateParameters();
    }

    private void parseParameters() {
        String[] requestLines = this.request.split("\r\n");
        try {

            for (String line : requestLines) {
                String[] lineSplitter = line.split("([:]?\\s)", 2);
                requestParameters.put(lineSplitter[0], lineSplitter[1]);
            }
        } catch (IndexOutOfBoundsException e) {
            valid = false;
        }
    }


    private void validateParameters() {
        ServerRequestValidator validator = new ServerRequestValidator();
        this.valid = validator.validate(this);
    }

    String getResponse() {
        ServerResponseBuilder builder = new ServerResponseBuilder(this);
        return builder.buildResponse();
    }

    public String getRequestType() {
        return requestType;
    }

    void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public String getParameter(String parameterName) {
        return requestParameters.get(parameterName);
    }

    public String getRequest() {
        return this.request;
    }

    public boolean isValid() {
        return valid;
    }
}