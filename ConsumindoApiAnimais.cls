@isTest
public class testCallout {
    @isTest static void testCalloutOk(){
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        httpResponse res = ConsumindoApiAnimais.chamadaApi();
        
        String actualValue = res.getBody();
        String expectedValue = '{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void testCalloutError(){
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorError());
        
        List<Object> animais = ConsumindoApiAnimais.usoLWC();
        System.assert(animais == null, 'A lista de animais deveria ser nula em caso de erro na API.');
        
    }
    
    @isTest
    static void testUsoLWCOk() {
        // Configura o mock para simular uma resposta bem-sucedida da API
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        List<Object> animaisRecebidos = ConsumindoApiAnimais.usoLWC();
        
        System.assertNotEquals(null, animaisRecebidos, 'A lista de animais não deveria ser nula.');
        System.assertEquals(4, animaisRecebidos.size(), 'A lista deveria conter 4 animais.');
        System.assertEquals('majestic badger', animaisRecebidos.get(0), 'O primeiro animal está incorreto.');
        System.assertEquals('fluffy bunny', animaisRecebidos.get(1), 'O segundo animal está incorreto.');
        System.assertEquals('scary bear', animaisRecebidos.get(2), 'O terceiro animal está incorreto.');
        System.assertEquals('chicken', animaisRecebidos.get(3), 'O quarto animal está incorreto.');
    }
    
    
    
    //=========================Fake responses=========================
    
    public class MockHttpResponseGenerator implements HttpCalloutMock{
        
        public httpResponse respond(HTTPRequest req){
            
            System.assertEquals('https://th-apex-http-callout.herokuapp.com/animals', req.getEndpoint());
            System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setBody('{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class MockHttpResponseGeneratorError implements HttpCalloutMock{
        
        public httpResponse respond(HTTPRequest req){
            
            System.assertEquals('https://th-apex-http-callout.herokuapp.com/animals', req.getEndpoint());
            System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setBody('');
            res.setStatusCode(404);
            return res;
        }
    }
    
}
