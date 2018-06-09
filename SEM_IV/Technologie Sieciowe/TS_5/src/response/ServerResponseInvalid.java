package response;

import body.ServerResponseContent;
import body.ServerResponseProperty;
import body.ServerResponseType;

public class ServerResponseInvalid implements ServerResponse {
    @Override
    public String get() {
        ServerResponseContent invalid = new ServerResponseContent();
        invalid.setType(ServerResponseType.BAD_REQUEST);
        invalid.addProperty(ServerResponseProperty.DATE)
                .addProperty(ServerResponseProperty.SERVER)
                .addProperty(ServerResponseProperty.CONNECTION_CLOSE);
        return invalid.getString();
    }
}
