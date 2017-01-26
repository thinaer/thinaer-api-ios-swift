/*
 Copyright 2010-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */
 

import AWSCore
import AWSAPIGateway

public class THINAERTHINaerClient: AWSAPIGatewayClient {

	static let AWSInfoClientKey = "THINAERTHINaerClient"

	private static let _serviceClients = AWSSynchronizedMutableDictionary()
	private static var token: dispatch_once_t = 0
	private static var _defaultClient:THINAERTHINaerClient?
    
	/**
	 Returns the singleton service client. If the singleton object does not exist, the SDK instantiates the default service client with `defaultServiceConfiguration` from `AWSServiceManager.defaultServiceManager()`. The reference to this object is maintained by the SDK, and you do not need to retain it manually.
	
	 If you want to enable AWS Signature, set the default service configuration in `func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)`
	
	     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	         let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
	         let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialProvider)
	         AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
	
	         return true
	     }
	
	 Then call the following to get the default service client:
	
	     let serviceClient = THINAERTHINaerClient.defaultClient()

     Alternatively, this configuration could also be set in the `info.plist` file of your app under `AWS` dictionary with a configuration dictionary by name `THINAERTHINaerClient`.
	
	 @return The default service client.
	 */ 
	 
	public class func defaultClient() -> THINAERTHINaerClient{
		var serviceConfiguration: AWSServiceConfiguration? = nil
		let serviceInfo = AWSInfo.defaultAWSInfo().defaultServiceInfo(AWSInfoClientKey)
		if let serviceInfo = serviceInfo {
			serviceConfiguration = AWSServiceConfiguration(region: serviceInfo.region, credentialsProvider: serviceInfo.cognitoCredentialsProvider)
		} else if (AWSServiceManager.defaultServiceManager().defaultServiceConfiguration != nil) {
			serviceConfiguration = AWSServiceManager.defaultServiceManager().defaultServiceConfiguration
		} else {
			serviceConfiguration = AWSServiceConfiguration(region: .Unknown, credentialsProvider: nil)
		}
		
		dispatch_once(&token) {
			_defaultClient = THINAERTHINaerClient(configuration: serviceConfiguration!)
		}
        
		return _defaultClient!
	}

	/**
	 Creates a service client with the given service configuration and registers it for the key.
	
	 If you want to enable AWS Signature, set the default service configuration in `func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)`
	
	     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	         let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
	         let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
	         THINAERTHINaerClient.registerClientWithConfiguration(configuration, forKey: "USWest2THINAERTHINaerClient")
	
	         return true
	     }
	
	 Then call the following to get the service client:
	
	
	     let serviceClient = THINAERTHINaerClient.client(forKey: "USWest2THINAERTHINaerClient")
	
	 @warning After calling this method, do not modify the configuration object. It may cause unspecified behaviors.
	
	 @param configuration A service configuration object.
	 @param key           A string to identify the service client.
	 */
	
	public class func registerClientWithConfiguration(configuration: AWSServiceConfiguration, forKey key: NSString){
		_serviceClients.setObject(THINAERTHINaerClient(configuration: configuration), forKey: key);
	}

	/**
	 Retrieves the service client associated with the key. You need to call `registerClientWithConfiguration(configuration, forKey:)` before invoking this method or alternatively, set the configuration in your application's `info.plist` file. If `registerClientWithConfiguration(configuration, forKey:)` has not been called in advance or if a configuration is not present in the `info.plist` file of the app, this method returns `nil`.
	
	 For example, set the default service configuration in `func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) `
	
	     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	         let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "YourIdentityPoolId")
	         let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
	         THINAERTHINaerClient.registerClientWithConfiguration(configuration, forKey: "USWest2THINAERTHINaerClient")
	
	         return true
	     }
	
	 Then call the following to get the service client:
	 
	 	let serviceClient = THINAERTHINaerClient.client(forKey: "USWest2THINAERTHINaerClient")
	 
	 @param key A string to identify the service client.
	 @return An instance of the service client.
	 */
	public class func client(forKey key: NSString) -> THINAERTHINaerClient {
		objc_sync_enter(self)
		if let client: THINAERTHINaerClient = _serviceClients.objectForKey(key) as? THINAERTHINaerClient {
			objc_sync_exit(self)
		    return client
		}

		let serviceInfo = AWSInfo.defaultAWSInfo().defaultServiceInfo(AWSInfoClientKey)
		if let serviceInfo = serviceInfo {
			let serviceConfiguration = AWSServiceConfiguration(region: serviceInfo.region, credentialsProvider: serviceInfo.cognitoCredentialsProvider)
			THINAERTHINaerClient.registerClientWithConfiguration(serviceConfiguration, forKey: key)
		}
		objc_sync_exit(self)
		return _serviceClients.objectForKey(key) as! THINAERTHINaerClient;
	}

	/**
	 Removes the service client associated with the key and release it.
	 
	 @warning Before calling this method, make sure no method is running on this client.
	 
	 @param key A string to identify the service client.
	 */
	public class func removeClient(forKey key: NSString) -> Void{
		_serviceClients.removeObjectForKey(key)
	}
	
	init(configuration: AWSServiceConfiguration) {
	    super.init()
	
	    self.configuration = configuration.copy() as! AWSServiceConfiguration
	    var URLString: String = "https://api.thinaer.io/v2"
	    if URLString.hasSuffix("/") {
	        URLString = URLString.substringToIndex(URLString.startIndex.advancedBy(URLString.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - 1))
	    }
	    self.configuration.endpoint = AWSEndpoint(region: configuration.regionType, service: .APIGateway, URL: NSURL(string: URLString)!)
	    let signer: AWSSignatureV4Signer = AWSSignatureV4Signer(credentialsProvider: configuration.credentialsProvider, endpoint: self.configuration.endpoint)
	    if let endpoint = self.configuration.endpoint {
	    	self.configuration.baseURL = endpoint.URL
	    }
	    self.configuration.requestInterceptors = [AWSNetworkingRequestInterceptor(), signer]
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func applicationGet(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("GET", URLString: "/application", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func applicationDevicesGet(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("GET", URLString: "/application/devices", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func applicationGatewaysGet(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("GET", URLString: "/application/gateways", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param uid 
     @param secret 
     
     return type: Empty
     */
    public func applicationTokenPost(uid: String?, secret: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "uid": uid!,
                   "secret": secret!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("POST", URLString: "/application/token", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func clientGet(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("GET", URLString: "/client", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func clientPost(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("POST", URLString: "/client", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func clientIdGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/client/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func clientIdPut(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("PUT", URLString: "/client/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func clientIdDelete(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("DELETE", URLString: "/client/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func clientIdDevicesGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/client/{id}/devices", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func clientIdGatewaysGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/client/{id}/gateways", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func clientIdVenuesGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/client/{id}/venues", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func deviceIdGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/device/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func deviceIdPut(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("PUT", URLString: "/device/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func gatewayIdGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/gateway/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func gatewayIdPut(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("PUT", URLString: "/gateway/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func gatewayIdSeesGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/gateway/{id}/sees", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func venueGet(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("GET", URLString: "/venue", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param token 
     
     return type: Empty
     */
    public func venuePost(token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    let pathParameters:[String:AnyObject] = [:]
	    
	    return self.invokeHTTPRequest("POST", URLString: "/venue", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func venueIdGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/venue/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func venueIdPut(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("PUT", URLString: "/venue/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func venueIdDelete(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("DELETE", URLString: "/venue/{id}", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func venueIdDevicesGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/venue/{id}/devices", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}

	
    /*
     
     
     @param id 
     @param token 
     
     return type: Empty
     */
    public func venueIdGatewaysGet(id: String, token: String?) -> AWSTask {
	    let headerParameters = [
                   "Content-Type": "application/json",
                   "Accept": "application/json",
                   "token": token!
	            ]
	    
	    let queryParameters:[String:AnyObject] = [:]
	    
	    var pathParameters:[String:AnyObject] = [:]
	    pathParameters["id"] = id
	    
	    return self.invokeHTTPRequest("GET", URLString: "/venue/{id}/gateways", pathParameters: pathParameters, queryParameters: queryParameters, headerParameters: headerParameters, body: nil, responseClass: Empty.self)
	}




}
