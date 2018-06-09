package body;

public enum ServerResponseType {
    OK("200 OK"),
    BAD_REQUEST("400 Bad Request"),
    NOT_FOUND("404 Not Found");

    private final String text;

    ServerResponseType(final String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return "HTTP/1.1 " + text + "\r\n";
    }
}
