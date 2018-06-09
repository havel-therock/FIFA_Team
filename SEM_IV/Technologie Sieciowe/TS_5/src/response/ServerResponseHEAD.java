package response;

import body.ServerResponseContent;
import body.ServerResponseProperty;
import body.ServerResponseType;

/**
 * Created by Piotr Szyma on 08.06.2017.
 */
public class ServerResponseHEAD implements ServerResponse {
    private String response;

    public ServerResponseHEAD() {
        generateResponse();
    }

    private void generateResponse() {
        ServerResponseContent responseContent = new ServerResponseContent();
        responseContent.setType(ServerResponseType.OK);
        responseContent.addProperty(ServerResponseProperty.DATE);
        responseContent.addProperty(ServerResponseProperty.SERVER);
        responseContent.addProperty(ServerResponseProperty.CONNECTION_CLOSE);
        responseContent.addProperty(ServerResponseProperty.CT_TEXT);
        response = responseContent.getString();
    }

    @Override
    public String get() {
        return response;
    }
}