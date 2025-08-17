public class ConsumindoApiAnimais {

    public static HttpResponse chamadaApi(){
       //Fazendo callout 
        HTTP http = new HTTP();
        httpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = Http.send(request); 
        return response;
     }

    //Função para callout ser usado no lwc

    @AuraEnabled(cacheable=true)
    public static List<object> usoLWC(){
        
        HttpResponse response = ConsumindoApiAnimais.chamadaApi();
            
        try{
            
            if(response.getStatusCode() == 200){
                
                MAP<String, object> results = (MAP<String, Object>)json.deserializeUntyped(response.getBody());
                
                List<object> animals = (list<object>)results.get('animals');
                return animals;
                
            }else{
                System.debug('Erro na resposta do callout: Status - '+response.getStatusCode());
                return null;
           		
            }
        
        }catch(calloutException e){
             System.debug('Erro na operação de callout: '+ e.getMessage());
            return null;
        }
    }
}
