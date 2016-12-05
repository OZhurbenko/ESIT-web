var config = require("./config/config");

var express = require('express');
var app = express();
var path = require('path');
var http = require("http");
var https = require("https");
//we need this to build our POST request
var querystring = require('querystring');
//added body-parser to grab information from the POST request
var bodyParser = require('body-parser');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
//end of body-parser

// DocuSign base url
var baseUrl;

//webpack hot load
var webpack = require('webpack');
var webpackConfig = require('./config/webpack.config');
var compiler = webpack(webpackConfig);
app.use(require("webpack-dev-middleware")(compiler, {
    noInfo: true, publicPath: webpackConfig.output.publicPath
}));
app.use(require("webpack-hot-middleware")(compiler));
//end of webpack hot load


app.use(express.static('dist'));
app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, './src/client/index.html'));
});


app.get('/dashboard', function(request, response) {

  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/SaleService/getAllSales/',
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var sales = JSON.parse(output).sales;
          //done with the sales, now retrieving the Installations
          var options = {
            host: config.crudIP,
            port: 8080,
            path: '/crud/InstallationService/getAllInstallations/',
            method: 'GET',
            headers: {
              'Content-Type': 'application/json'
            }
          };

          var installRequest = http.request(options, function(resp)
            {
              var output = '';
              resp.setEncoding('utf8');

              resp.on('data', function (chunk) {
                output += chunk;
              });

              resp.on('end', function() {
                  var installations = JSON.parse(output).installations;
                  var entry = {
                    data: {
                      'sales': sales,
                      'installations': installations
                    }
                  };
                  return response.status(200).json(entry);
              });
            });

            installRequest.on('error', function(err) {
                //response.send('error: ' + err.message);
            });

            installRequest.end();
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});


app.get('/allsales', function(request, response) {

  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/SaleService/getAllSales/',
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var sales = JSON.parse(output);
          return response.status(200).json(sales);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});


app.get('/allinstallations', function(request, response) {

  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/InstallationService/getAllInstallations/',
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var obj = JSON.parse(output);
          return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});


app.get('/allcustomers', function(request, response) {

  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/CustomerService/getAllCustomers/',
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var obj = JSON.parse(output);
          return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});


app.get('/allemployees', function(request, response) {

  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/EmployeeService/getAllEmployees/',
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var obj = JSON.parse(output);
          return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});

app.get('/existingsale', function(request, response) {
  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/SaleService/getSaleById/' + request.query.id,
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var obj = JSON.parse(output);
          return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});

app.get('/getoneemployee', function(request, response) {
  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/EmployeeService/getEmployeeById/' + request.query.id,
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var obj = JSON.parse(output);
          return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});

//POST http://localhost:3000/newsale
app.post('/newsale', function(request, response) {
  var jsonObj = querystring.stringify({
    //homeowner's info
    fname: request.body.fname,
    lname: request.body.lname,
    address: request.body.address,
    unitNum: request.body.unitNum,
    city: request.body.city,
    province: request.body.province,
    postalCode: request.body.postalCode,
    enbridge: request.body.enbridge,
    email: request.body.email,
    homePhone: request.body.homePhone,
    cellPhone: request.body.cellPhone,
    //program type
    programType: request.body.programType,
    //Installation & Delivery
    installationDate: request.body.installationDate,
    installationTime: request.body.installationTime,
    notes: request.body.notes,

    //the rest
    dateSigned: request.body.dateSigned,
    salesRepId: request.body.salesRepId
  });

  var options = {
    host: config.crudIP,
    port: 8080,
    method: 'POST',
    path: '/crud/SaleService/createNewSale',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Length': Buffer.byteLength(jsonObj)
    }
  };

  var req = http.request(options, function(res) {
    var output = '';
    res.setEncoding('utf8');
    res.on('data', function (chunk) {
        output += chunk;
    });

    res.on('end', function() {

      //#TODO remove tempObj and forward the SaleNumber from crud instead
      var tempObj = {'a': 'b'};
      return response.status(200).json(tempObj);
    });

  });

  req.on('error', function(err) {
    console.log('error message');
    //response.send('error: ' + err.message);
  });

  req.write(jsonObj);
  req.end();
});

app.get('/getoneinstallation', function(request, response) {
  var options = {
    host: config.crudIP,
    port: 8080,
    path: '/crud/InstallationService/getInstallationById/' + request.query.id,
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  var object = undefined;
  var req = http.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
          var obj = JSON.parse(output);
          return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
        //response.send('error: ' + err.message);
    });

    req.end();
});

app.get('/getbaseurl', function(request, response) {
  // Prepare DocuSign header
  var dsAuthHeader = JSON.stringify({
		'Username': config.docusign.email,
		'Password': config.docusign.password,
		'IntegratorKey': config.docusign.integratorKey
	});

  var options = {
    hostname: 'demo.docusign.net',
    path: '/restapi/v2/login_information',
    method: 'GET',
    body: '',
    headers: {
      'Content-Type': 'application/json',
      'X-DocuSign-Authentication' : dsAuthHeader
    }
  };

  // Note HTTPS request here
  var req = https.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
        var obj = JSON.parse(output);
        baseUrl = obj.loginAccounts[0].baseUrl
        return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
      console.log(err);
      response.send('error: ' + err.message);
    });

    req.end();
});

app.post('/getenvelopeid', function(request, response) {
  var url = "/restapi/v2/accounts/1848997/envelopes";
  // Prepare the request body
  var body = JSON.stringify({
      "emailSubject": "DocuSign API call - Embedded Sending Example",
      "templateId": config.docusign.saleTemplateId,
      "templateRoles": [{
        "email": request.query.email,
        "name": request.query.recipientName,
        "roleName": "Customer",
        "clientUserId": "1001",	// user-configurable
        "tabs" : {
          "textTabs" : [{
               tabLabel : "customerSalesNumber",
               value : "123456789"
              },
              {
                  tabLabel : "customerFName",
                  value : "Klever"
              },
              {
                  tabLabel : "customerLName",
                  value : "Loza Vega"
              },
              {
                  tabLabel : "customerAddress",
                  value : "70 The Pond Road"
              },
              {
                  tabLabel : "customerCity",
                  value : 'Toronto'
              },
              {
                  tabLabel : "customerPostalCode",
                  value : 'M6M1J4'
              }
          ]
        }
      }],
      "status": "sent"
    });
  // Prepare DocuSign header
  var dsAuthHeader = JSON.stringify({
		'Username': config.docusign.email,
		'Password': config.docusign.password,
		'IntegratorKey': config.docusign.integratorKey
	});

  var options = {
    hostname: 'demo.docusign.net',
    path: url,
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(body),
      'X-DocuSign-Authentication' : dsAuthHeader
    }
  };
console.log(options);
  // Note HTTPS request here
  var req = https.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
        var obj = JSON.parse(output);
        console.log(obj);
        return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
      console.log(err);
      response.send('error: ' + err.message);
    });

    req.write(body);
    req.end();
});

app.post('/getembeddedurl', function(request, response) {
  var url = "/restapi/v2/accounts/1848997/envelopes/" + request.query.envelopeId + "/views/recipient";
  // Prepare the request body
    var body = JSON.stringify({
				"returnUrl": "http://www.docusign.com/devcenter",
				"authenticationMethod": "email",
				"email": request.query.email,
				"userName": request.query.recipientName,
				"clientUserId": "1001",	// must match clientUserId in step 2!
			});
  // Prepare DocuSign header
  var dsAuthHeader = JSON.stringify({
		'Username': config.docusign.email,
		'Password': config.docusign.password,
		'IntegratorKey': config.docusign.integratorKey
	});

  var options = {
    hostname: 'demo.docusign.net',
    path: url,
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(body),
      'X-DocuSign-Authentication' : dsAuthHeader
    }
  };
console.log(options);
  // Note HTTPS request here
  var req = https.request(options, function(res)
    {
      var output = '';
      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        output += chunk;
      });

      res.on('end', function() {
        var obj = JSON.parse(output);
        console.log(obj);
        return response.status(200).json(obj);
      });
    });

    req.on('error', function(err) {
      console.log(err);
      response.send('error: ' + err.message);
    });

    req.write(body);
    req.end();
});

app.listen(3000, function(err) {
  console.log('Listening at http://... 3000');
});
