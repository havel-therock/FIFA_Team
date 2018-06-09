package body;

import java.util.Date;

public enum ServerResponseProperty {
    CONNECTION_CLOSE("Connection: close"),
    SERVER("Server: Thompson/1.0 (Windows 10)"),
    DATE("Date " + new Date()),
    CT_HTML("Content-Type: text/html"),
    CT_TEXT("Content-Type: text/text"),
    CT_CSS("Content-Type: text/css"),
    CT_JS("Content-Type: application/javascript");
    private final String text;

    ServerResponseProperty(final String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return text + "\r\n";
    }
}
