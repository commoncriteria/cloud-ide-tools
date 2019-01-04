package snac;
import javax.xml.validation;
import javax.xml.XMLConstants;
import javax.xml.parsers;
import javax.xml.transform.dom;

public class RNGValidator{
    public static void main(String []args) throws Exception{
        // parse an XML document into a DOM tree
        DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        Document document = parser.parse(new File(args[1]));

        // create a SchemaFactory capable of understanding WXS schemas
        SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.RELAXNG_NS_URI);

        // load a WXS schema, represented by a Schema instance
        Source schemaFile = new StreamSource(new File(args[0]));
        Schema schema = factory.newSchema(schemaFile);

        // create a Validator instance, which can be used to validate an instance document
        Validator validator = schema.newValidator();
        validator.validate(new DOMSource(document));
    }
}