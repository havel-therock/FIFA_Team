package response;

import body.ServerResponseContent;
import body.ServerResponsePage;
import body.ServerResponseProperty;
import body.ServerResponseType;
import server.ServerLogger;
import server.ServerRequest;
import server.ServerRequestFileType;

import java.io.File;
import java.io.IOException;


public class ServerResponseGET implements ServerResponse {

    private String response;
    private String file;


    public ServerResponseGET(ServerRequest request) {
        String parameters = request.getParameter("GET");
        this.file = parameters.substring(0, parameters.lastIndexOf(" "));
        this.file = file.replace("/", "\\");
        this.file = file.replaceAll("\\\\+", "\\\\");
        generateResponse();
    }

    private void generateResponse() {

        String contentDirectory = System.getProperty("user.dir") + "\\public_html";
        String fileName = file;

        if (fileName.isEmpty() || fileName.endsWith("\\")) {
            fileName += "index.html";
        }

        ServerRequestFileType fileType;

        if (fileName.endsWith(".js")) {
            fileType = ServerRequestFileType.JS;
        } else if (fileName.endsWith(".css")) {
            fileType = ServerRequestFileType.CSS;
        } else {
            fileType = ServerRequestFileType.HTML;
        }

        String filePath = contentDirectory + fileName;
        String fileContent;
        File file = new File(filePath);

        ServerResponseContent responseContent = new ServerResponseContent();

        if (file.exists()) {
            responseContent.setType(ServerResponseType.OK);
            switch (fileType) {
                case JS:
                    responseContent.addProperty(ServerResponseProperty.CT_JS);
                    break;
                case CSS:
                    responseContent.addProperty(ServerResponseProperty.CT_CSS);
                    break;
                case HTML:
                    responseContent.addProperty(ServerResponseProperty.CT_HTML);
                    break;
                default:
                    responseContent.addProperty(ServerResponseProperty.CT_TEXT);
                    break;
            }

        } else {
            filePath = contentDirectory + "\\404.html";
            responseContent.setType(ServerResponseType.NOT_FOUND);
        }

        ServerResponsePage content;
        try {
            content = new ServerResponsePage(filePath, fileType);
            fileContent = content.getPage();

            responseContent.addProperty(ServerResponseProperty.DATE)
                    .addProperty(ServerResponseProperty.SERVER)
                    .addProperty(ServerResponseProperty.CONNECTION_CLOSE)
                    .addBody(fileContent);

            response = responseContent.getString();
        } catch (IOException e) {
            ServerLogger.log("Unable to get content from file on disk");
            response = "";
        }

    }

    @Override
    public String get() {
        return response;
    }
}
