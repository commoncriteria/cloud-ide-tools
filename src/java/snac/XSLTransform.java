package snac;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

public class XSLTransform {
    public static void main(String[] args) throws IOException, URISyntaxException, TransformerException {
        if (args.length != 3){
            System.out.println("Usage: <xsl-file> <xml-file> <out-file>");
            return;
        }
        TransformerFactory factory = TransformerFactory.newInstance();
        Source xslt = new StreamSource(new File(args[0]));
        xslt.setParameter("basesdir", "/projects/bases");
        xslt.setParameter("appendicize", "on");
        Transformer transformer = factory.newTransformer(xslt);

        Source text = new StreamSource(new File(args[1]));
        transformer.transform(text, new StreamResult(new File(args[2])));
    }
}