package body;

import server.ServerRequestFileType;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Collectors;
import java.util.stream.Stream;


public class ServerResponsePage {
    private String pageContent = "";

    public ServerResponsePage(String bodyFile, ServerRequestFileType fileType) throws IOException {
        String contentDirectory = System.getProperty("user.dir") + "\\public_html";
        String headerFile = contentDirectory + "\\header.html";
        String footerFile = contentDirectory + "\\footer.html";

        switch (fileType) {
            case HTML:
                addFileContent(headerFile);
                addFileContent(bodyFile);
                addFileContent(footerFile);
                break;
            default:
                addFileContent(bodyFile);
                break;
        }

    }

    public String getPage() {
        return pageContent;
    }

    private void addFileContent(String fileName) throws IOException {
        try (Stream<String> s = Files.lines(Paths.get(fileName))) {
            pageContent += s.collect(Collectors.joining());
        }
    }
}
