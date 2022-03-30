
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdate( _ cc: WeatherModel )
    func didFailwithError(_ error: Error)
    
}

struct WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?&appid=11808d33671f7421755094741797c900&units=metric"
    
    func fetch( _ urlString : String)  {
        let finalURL = "\(weatherURL)&q=\(urlString)"
        perform(urlString: finalURL)
    }
    
    func fetch(lat : CLLocationDegrees , lon: CLLocationDegrees)  {
        let finalURL="\(weatherURL)&lat=\(lat)&lon=\(lon)"
         perform(urlString: finalURL)
    }
    
    
    
    func perform(urlString: String)  {
        // 1. Create a URL
        let myURL = URL(string: urlString)
        
        if myURL != nil{
            
            // 2. Create a URL Session
            let urlSession = URLSession(configuration: .default)
            
            // 3. Give the Session a task
            let givenTask = urlSession.dataTask(with: myURL!, completionHandler: handler(data: urlRes:  myerr:))
            
            // 4. Start the task
            givenTask.resume()
        }
    }
    
    func handler(data: Data?, urlRes: URLResponse?, myerr: Error?)  {
        if(myerr != nil){
            delegate?.didFailwithError(myerr!)
            return
        }
        
        if let recdata = data{
            if let obj2 = parseJSON(recdata){
                delegate?.didUpdate(obj2)
            }
        }
}
    
    
    func parseJSON(_ myData: Data) -> WeatherModel? {
        let decoder=JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: myData)
            let id=decodedData.weather[0].id
            let name=decodedData.name
            let temperature=decodedData.main.temp
            
            let obj = WeatherModel( id: id, name: name, temp: temperature)
            return obj
        }catch{
            delegate?.didFailwithError(error)
            return nil
            
        }
        
    }

    

    
    
    
    
    
}
