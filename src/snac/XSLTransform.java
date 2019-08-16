package snac;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;


public class XSLTransform {
    public static void main(String[] args) throws IOException, URISyntaxException, TransformerException {
        if (args.length < 3){
            System.out.println("Usage: <xsl-file> <xml-file> <out-file> [<param1-name>=<param1-value> [<param2-name>=<param2-value>[...]]]");
            return;
        }

        TransformerFactory factory = TransformerFactory.newInstance();
        Source xslt = new StreamSource(new File(args[0]));
        Transformer transformer = factory.newTransformer(xslt);
        for(int aa=3; aa<args.length; aa++){
            String []nameAndVal=args[aa].split("=", 2);
            transformer.setParameter(nameAndVal[0], nameAndVal[1]);
        }

        Source text = new StreamSource(new File(args[1]));
        StreamResult result;
        if (args[2].equals("-")){
          result=new StreamResult(System.out);
        }
        else{
          result=new StreamResult(new File(args[2]));
        }
        transformer.transform(text, result);
    }
}