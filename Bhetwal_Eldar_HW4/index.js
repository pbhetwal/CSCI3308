//Parikshit Bhetwal and Omer Eldar
var state_info = {
    'AL': {'lat': 32.3792233, 'lng': -86.3077368, 'capital': 'Montgomery'},
    'AK': {'lat': 58.3019444, 'lng': -134.4197221, 'capital': 'Juneau'},
    'AZ': {'lat': 33.4483771, 'lng': -112.0740373, 'capital': 'Phoenix'},
    'AR': {'lat': 34.7464809, 'lng': -92.28959479999999, 'capital': 'Little Rock'},
    'CA': {'lat': 38.5815719, 'lng': -121.4943996, 'capital': 'Sacramento'},
    'CO': {'lat': 39.7392358, 'lng': -104.990251, 'capital': 'Denver'},
    'CT': {'lat': 41.7658043, 'lng': -72.6733723, 'capital': 'Hartford'},
    'DE': {'lat': 39.158168, 'lng': -75.5243682, 'capital': 'Dover'},
    'FL': {'lat': 30.4382559, 'lng': -84.28073289999999, 'capital': 'Tallahassee'},
    'GA': {'lat': 33.7489954, 'lng': -84.3879824, 'capital': 'Atlanta'},
    'HI': {'lat': 21.3069444, 'lng': -157.8583333, 'capital': 'Honolulu'},
    'ID': {'lat': 43.6150186, 'lng': -116.2023137, 'capital': 'Boise'},
    'IL': {'lat': 39.78172130000001, 'lng': -89.6501481, 'capital': 'Springfield'},
    'IN': {'lat': 39.768403, 'lng': -86.158068, 'capital': 'Indianapolis'},
    'IA': {'lat': 41.5868353, 'lng': -93.6249593, 'capital': 'Des Moines'},
    'KS': {'lat': 39.0473451, 'lng': -95.67515759999999, 'capital': 'Topeka'},
    'KY': {'lat': 38.2009055, 'lng': -84.87328350000001, 'capital': 'Frankfort'},
    'LA': {'lat': 30.4514677, 'lng': -91.18714659999999, 'capital': 'Baton Rouge'},
    'ME': {'lat': 44.3106241, 'lng': -69.7794897, 'capital': 'Augusta'},
    'MD': {'lat': 38.9784453, 'lng': -76.4921829, 'capital': 'Annapolis'},
    'MA': {'lat': 42.3600825, 'lng': -71.0588801, 'capital': 'Boston'},
    'MI': {'lat': 42.732535, 'lng': -84.5555347, 'capital': 'Lansing'},
    'MN': {'lat': 44.9537029, 'lng': -93.0899578, 'capital': 'Saint Paul'},
    'MS': {'lat': 32.2987573, 'lng': -90.1848103, 'capital': 'Jackson'},
    'MO': {'lat': 38.57670170000001, 'lng': -92.1735164, 'capital': 'Jefferson City'},
    'MT': {'lat': 46.5891452, 'lng': -112.0391057, 'capital': 'Helena'},
    'NE': {'lat': 40.813616, 'lng': -96.7025955, 'capital': 'Lincoln'},
    'NV': {'lat': 39.1637984, 'lng': -119.7674034, 'capital': 'Carson City'},
    'NH': {'lat': 43.2081366, 'lng': -71.5375718, 'capital': 'Concord'},
    'NJ': {'lat': 40.2205824, 'lng': -74.759717, 'capital': 'Trenton'},
    'NM': {'lat': 35.6869752, 'lng': -105.937799, 'capital': 'Santa Fe'},
    'NY': {'lat': 42.6525793, 'lng': -73.7562317, 'capital': 'Albany'},
    'NC': {'lat': 35.7795897, 'lng': -78.6381787, 'capital': 'Raleigh'},
    'ND': {'lat': 46.8083268, 'lng': -100.7837392, 'capital': 'Bismarck'},
    'OH': {'lat': 39.9611755, 'lng': -82.99879419999999, 'capital': 'Columbus'},
    'OK': {'lat': 35.4675602, 'lng': -97.5164276, 'capital': 'Oklahoma City'},
    'OR': {'lat': 44.9428975, 'lng': -123.0350963, 'capital': 'Salem'},
    'PA': {'lat': 40.2731911, 'lng': -76.8867008, 'capital': 'Harrisburg'},
    'RI': {'lat': 41.8239891, 'lng': -71.4128343, 'capital': 'Providence'},
    'SC': {'lat': 34.0007104, 'lng': -81.0348144, 'capital': 'Columbia'},
    'SD': {'lat': 44.36678759999999, 'lng': -100.3537522, 'capital': 'Pierre'},
    'TN': {'lat': 36.1626638, 'lng': -86.7816016, 'capital': 'Nashville'},
    'TX': {'lat': 30.267153, 'lng': -97.7430608, 'capital': 'Austin'},
    'UT': {'lat': 40.7607793, 'lng': -111.8910474, 'capital': 'Salt Lake City'},
    'VT': {'lat': 44.26005929999999, 'lng': -72.5753869, 'capital': 'Montpelier'},
    'VA': {'lat': 37.5407246, 'lng': -77.4360481, 'capital': 'Richmond'},
    'WA': {'lat': 47.0378741, 'lng': -122.9006951, 'capital': 'Olympia'},
    'WV': {'lat': 38.3498195, 'lng': -81.6326234, 'capital': 'Charleston'},
    'WI': {'lat': 43.0730517, 'lng': -89.4012302, 'capital': 'Madison'},
    'WY': {'lat': 41.1399814, 'lng': -104.8202462, 'capital': 'Cheyenne'}
};

$(document).ready(function() {
	//Reference to Gist from write-up 
	Object.keys(state_info).forEach(function(key) {
	    var value = state_info[key];
	    var state_key = '#' + key; 
	    
	    //Must get information for specific state
	    //Reference to code from Lab 7 for using DarkSky API, with variable name 'url'
	    var url ='https://api.forecast.io/forecast/986cd4fe151a5e51cbe4de15d41fafd5/' + value.lat + ',' + value.lng; 
	    $.ajax({url:url, dataType:"jsonp"}).then(function(data) {
	    	//Get the temperature, which we will use to determine color 
		    var temp = data.currently.temperature; 
		    console.log(state_key, temp);

		    //Check for temperature values to determine color 
		    //DarkSky API uses decimal precision for temperature, so we used decimal values for comparison 

		    //We need to consider values before 11 degrees, which include 10.1, 10.2, 10.3, etc., which would still be 10 degrees 
		    if (temp <= 10.99)
		    {
		    	$(state_key).css('fill', 'blue');
		    }

		    //11F to 30F
		    //This way 30.5, 30.6 etc. are included 
		    else if (temp >= 11 && temp < 31)
		    {
		    	$(state_key).css('fill', 'cyan');
		    }

		    //31F to 50F
		    //This way 50.5, 50.6 etc. are included 
		    else if (temp >= 31 && temp < 51)
		    {
		    	$(state_key).css('fill', 'green');
		    }

		    //51F to 80F
		    else if (temp >= 51 && temp <= 80)
		    {
		    	$(state_key).css('fill', 'orange');
		    }

		    //Greater than 80F
		    //As soon as it is greater than 80, such as 80.1, the temperature is red 
		    else if (temp > 80)
		    {
		    	$(state_key).css('fill', 'red');
		    }

		    //This should not happen if we have considered all possible temperatures 
		    else
		    {
		    	$(state_key).css('fill', 'gray');
		    }

		})

	});
});