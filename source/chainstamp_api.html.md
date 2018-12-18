---
title: Chainstamp REST API
language_tabs:
  - shell: Shell
  - http: HTTP
  - javascript: JavaScript
  - javascript--nodejs: Node.JS
  - ruby: Ruby
  - python: Python
  - java: Java
  - go: Go
toc_footers: []
includes: []
search: true
highlight_theme: darkula
headingLevel: 2

---

<h1 id="chainstamp-rest-api">Chainstamp REST API Version 1.1</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

### Welcome to the Chainstamp API.

Below you'll find the API operations needed to create and verify Chainstamp proofs (blockchain timestamps of your digital files). Using the blockchain to timestamp your data can prove it existed at that point in time and has not been altered since. 

This release contains only our free APIs. No registration needed. See [chainstamp.io](https://chainstamp.io) for other services with faster confirmation times.

## Hashing
Some of the operations shown below require a "hash" or a kind of digital fingerprint of your data. Hashes in Chainstamp APIs are allways sha256 based hashes and can be computed using standard tools like "shasum" (```shasum -a 256 myfile.txt```),  "CertUtil" (```CertUtil -hashfile C:\TEMP\MyDataFile.img SHA256 ```) or by computing hashes directly in the programing language of your choice.

## Backup your files

A blockchain timestamp like the Chainstamp proof is only useful if you have an unaltered copy of your original digital file to check it against. We recommend keeping a separate directory (perhaps in the cloud) of all your timestamped files.

##Examples 

### Create example

>Create a chainstamp proof (blockchain timestmap) for demoTape.mp3 :

```
hashed=($(shasum -a 256 demoTape.mp3))

curl -X POST https://api.chainstamp.io:8443/stamp/basic/ \
  -H 'Content-Type: application/json'  \
   -d '{"originalHashes":["'"$hashed"'"], "emailToNotify":"paul@chainstamp.io"}' 
```

See the example to the right. First a hash of the file "demoTape.mp3" is created. Then this hash is passed to the api using the curl POST command. Note here a variable is passed ("hashed") to the curl command. You can also just use the raw data like "originalHashes":["b1e1dd094de9284f5f590f91923aaca85308b4883479a830b71e5fe962f7a259"] there. 

For multiple hashes, separate with a comma. Limit of 3 for the free version.

### Verify example

>Verify a file using its hash :

```
curl -X GET \
  https://api.chainstamp.io:8443/verify/item/b1e1dd094de9284f5f590f91923aaca85308b4883479a830b71e5fe962f7a259 
```

See the example to the right. 

Run this and you'll get an output indicates that the file used to create that hash ("b1e1dd09..."), was part of a chainstamp proof that is in block 523,051 which entered the blockchain at a time of 1526521962000 or 05/17/2018 @ 1:52:42am (UTC)

### Proof file

>Retrieve the proof file :

```
curl -X GET https://api.chainstamp.io:8443/proof/7a4d4273b80ca56894a326fde7803886802ce116044063e801280eec43fd4678 > demoTape.proof
```

From the **output** produced in the verify example above, copy the seedHash value and use it to retrieve the proof file. As shown on the right. 

If you hash the proof file itself (shasum -a 256 demoTape.proof) you'll get the seedHash value back. More importantly you'll see the original hash value from the demoTape.mp3 "b1e1dd094de9284f5f590f91923aaca85308b4883479a830b71e5fe962f7a259" also appears in the proof file.

Lookup the [transaction](https://www.blockchain.com/btc/tx/3b4faa182aafb16e0cce0046a87f1b676a35b575e39ad29026d6c89d7214cbec) (see the verify output again) and see the seedHash value of 7a4d4273b80ca56894a326fde7803886802ce116044063e801280eec43fd4678 appears in one of the tx Outputs.

More info on proof files [here](https://chainstamp.io/faq.html#proofFile).

## General Info

Base URLs:

* <a href="https://api.chainstamp.io:8443/">https://api.chainstamp.io:8443/</a>

<a href="https://chainstamp.io/terms.html">Terms of service</a>
Email: <a href="mailto:contact@chainstamp.io">Chainstamp</a> Web: <a href="https://chainstamp.io">Chainstamp</a> 

<h1 id="chainstamp-rest-api-verify">Verify</h1>

## get-proof-file

<a id="opIdget-proof-file"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://api.chainstamp.io:8443/proof/{seedHash} \
  -H 'Accept: */*'

```

```http
GET https://api.chainstamp.io:8443/proof/{seedHash} HTTP/1.1
Host: api.chainstamp.io:8443
Accept: */*

```

```javascript
var headers = {
  'Accept':'*/*'

};

$.ajax({
  url: 'https://api.chainstamp.io:8443/proof/{seedHash}',
  method: 'get',

  headers: headers,
  success: function(data) {
    console.log(JSON.stringify(data));
  }
})

```

```javascript--nodejs
const fetch = require('node-fetch');

const headers = {
  'Accept':'*/*'

};

fetch('https://api.chainstamp.io:8443/proof/{seedHash}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Accept' => '*/*'
}

result = RestClient.get 'https://api.chainstamp.io:8443/proof/{seedHash}',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Accept': '*/*'
}

r = requests.get('https://api.chainstamp.io:8443/proof/{seedHash}', params={

}, headers = headers)

print r.json()

```

```java
URL obj = new URL("https://api.chainstamp.io:8443/proof/{seedHash}");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("GET");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Accept": []string{"*/*"},
        
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("GET", "https://api.chainstamp.io:8443/proof/{seedHash}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /proof/{seedHash}`

*Get a proof file using a seed hash*

The proof file is your way to validate a Chainstamp proof independently. This method will return a plain text list of sha256 list of hashes which can be saved as a text file. The hashes in that file correspond to hashes of files submitted to us and hashed together to create a 'seedHash' which is submitted to the bitcoin blockchain in a transaction output.

<h3 id="get-proof-file-parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|seedHash|path|string|true|The sha256 hash of your proof file.|

> Example responses

> 200 Response

<h3 id="get-proof-file-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|string|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Error|[ErrorWrapper](#schemaerrorwrapper)|

<aside class="success">
This operation does not require authentication
</aside>

## verify-item

<a id="opIdverify-item"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://api.chainstamp.io:8443/verify/item/{itemHash} \
  -H 'Accept: application/json'

```

```http
GET https://api.chainstamp.io:8443/verify/item/{itemHash} HTTP/1.1
Host: api.chainstamp.io:8443
Accept: application/json

```

```javascript
var headers = {
  'Accept':'application/json'

};

$.ajax({
  url: 'https://api.chainstamp.io:8443/verify/item/{itemHash}',
  method: 'get',

  headers: headers,
  success: function(data) {
    console.log(JSON.stringify(data));
  }
})

```

```javascript--nodejs
const fetch = require('node-fetch');

const headers = {
  'Accept':'application/json'

};

fetch('https://api.chainstamp.io:8443/verify/item/{itemHash}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Accept' => 'application/json'
}

result = RestClient.get 'https://api.chainstamp.io:8443/verify/item/{itemHash}',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Accept': 'application/json'
}

r = requests.get('https://api.chainstamp.io:8443/verify/item/{itemHash}', params={

}, headers = headers)

print r.json()

```

```java
URL obj = new URL("https://api.chainstamp.io:8443/verify/item/{itemHash}");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("GET");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Accept": []string{"application/json"},
        
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("GET", "https://api.chainstamp.io:8443/verify/item/{itemHash}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /verify/item/{itemHash}`

*Verify status of a file (item)*

Use this endpoint with the hash of a digitial file to check its status. Pass the sha256 hash of any digital file as the {itemHash}.

<h3 id="verify-item-parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|itemHash|path|string|true|The sha256 hash of a file you submitted for a chainstamp proof.|

> Example responses

> 200 Response

```json
{
  "blockHash": "string",
  "blockNumber": 0,
  "blockTime": "2018-12-17T03:55:23Z",
  "confirmations": 0,
  "expectedSubmissionTime": 0,
  "seedHash": "string",
  "status": 0,
  "txId": "string",
  "txTime": "2018-12-17T03:55:23Z"
}
```

<h3 id="verify-item-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[VerifyItemStatus](#schemaverifyitemstatus)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Error|[ErrorWrapper](#schemaerrorwrapper)|

<aside class="success">
This operation does not require authentication
</aside>

## verify-stamp

<a id="opIdverify-stamp"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash} \
  -H 'Accept: application/json'

```

```http
GET https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash} HTTP/1.1
Host: api.chainstamp.io:8443
Accept: application/json

```

```javascript
var headers = {
  'Accept':'application/json'

};

$.ajax({
  url: 'https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash}',
  method: 'get',

  headers: headers,
  success: function(data) {
    console.log(JSON.stringify(data));
  }
})

```

```javascript--nodejs
const fetch = require('node-fetch');

const headers = {
  'Accept':'application/json'

};

fetch('https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Accept' => 'application/json'
}

result = RestClient.get 'https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash}',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Accept': 'application/json'
}

r = requests.get('https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash}', params={

}, headers = headers)

print r.json()

```

```java
URL obj = new URL("https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash}");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("GET");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Accept": []string{"application/json"},
        
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("GET", "https://api.chainstamp.io:8443/verify/stamp/{stampId}/{stampHash}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /verify/stamp/{stampId}/{stampHash}`

*Verify status*

Verify status using a stampId and a stampHash. Use this method to check the status of a Chainstamp proof. If the stampId or stampHash is unknown, use the /verify/item/{itemHash} endpoint instead.

<h3 id="verify-stamp-parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|stampId|path|integer(int64)|true|The stampId returned from the OpenResponse object.|
|stampHash|path|string|true|The sha256 hash of the originalHashes returned in the OpenResponse object.|

> Example responses

> 200 Response

```json
{
  "blockHash": "string",
  "blockNumber": 0,
  "blockTime": "2018-12-17T03:55:23Z",
  "confirmations": 0,
  "expectedSubmissionTime": 0,
  "paid": false,
  "paymentLevel": "string",
  "seedHash": "string",
  "status": 0,
  "txId": "string",
  "txTime": "2018-12-17T03:55:23Z"
}
```

<h3 id="verify-stamp-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[VerifyStatus](#schemaverifystatus)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Error|[ErrorWrapper](#schemaerrorwrapper)|

<aside class="success">
This operation does not require authentication
</aside>

<h1 id="chainstamp-rest-api-create">Create</h1>

## stamp-basic

<a id="opIdstamp-basic"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://api.chainstamp.io:8443/stamp/basic \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json'

```

```http
POST https://api.chainstamp.io:8443/stamp/basic HTTP/1.1
Host: api.chainstamp.io:8443
Content-Type: application/json
Accept: application/json

```

```javascript
var headers = {
  'Content-Type':'application/json',
  'Accept':'application/json'

};

$.ajax({
  url: 'https://api.chainstamp.io:8443/stamp/basic',
  method: 'post',

  headers: headers,
  success: function(data) {
    console.log(JSON.stringify(data));
  }
})

```

```javascript--nodejs
const fetch = require('node-fetch');
const inputBody = '{
  "emailToNotify": "string",
  "originalHashes": [
    "string"
  ]
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json'

};

fetch('https://api.chainstamp.io:8443/stamp/basic',
{
  method: 'POST',
  body: inputBody,
  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Content-Type' => 'application/json',
  'Accept' => 'application/json'
}

result = RestClient.post 'https://api.chainstamp.io:8443/stamp/basic',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
}

r = requests.post('https://api.chainstamp.io:8443/stamp/basic', params={

}, headers = headers)

print r.json()

```

```java
URL obj = new URL("https://api.chainstamp.io:8443/stamp/basic");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("POST");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Content-Type": []string{"application/json"},
        "Accept": []string{"application/json"},
        
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("POST", "https://api.chainstamp.io:8443/stamp/basic", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /stamp/basic`

*Create a free chainstamp proof.*

Use this operation to create a blockchain timestamp (Chainstamp proof) for any digital documents. This api is free and will be submittd to the bitcoin network within 24hrs. Our paid apis (comming soon) ,and our web interface, allow for faster or immediate submission.<br/><br/>Limits: Free version allows only up to 3 file hashes in 'originalHashes' array.

> Body parameter

```json
{
  "emailToNotify": "string",
  "originalHashes": [
    "string"
  ]
}
```

<h3 id="stamp-basic-parameters">Parameters</h3>

|Parameter|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[StampBasicRequest](#schemastampbasicrequest)|true|basicRequest|

> Example responses

> 200 Response

```json
{
  "expectedSubmissionTime": 0,
  "originalHashes": [
    "string"
  ],
  "paymentAddress": "string",
  "paymentAmtBtc": 0,
  "paymentId": 0,
  "seedHash": "string",
  "seedId": 0,
  "stampHash": "string",
  "stampId": 0,
  "status": 0,
  "transactionId": "string"
}
```

<h3 id="stamp-basic-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[OpenResponse](#schemaopenresponse)|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Created|None|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized|None|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden|None|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found|None|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Error|[ErrorWrapper](#schemaerrorwrapper)|

<aside class="success">
This operation does not require authentication
</aside>

# Schemas

<h2 id="tocSerrorwrapper">ErrorWrapper</h2>

<a id="schemaerrorwrapper"></a>

```json
{
  "code": 0,
  "message": "string",
  "path": "string",
  "status": 0,
  "title": "string"
}

```

*ErrorWrapper*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|code|integer(int32)|false|none|none|
|message|string|false|none|none|
|path|string|false|none|none|
|status|integer(int32)|false|none|none|
|title|string|false|none|none|

<h2 id="tocSopenresponse">OpenResponse</h2>

<a id="schemaopenresponse"></a>

```json
{
  "expectedSubmissionTime": 0,
  "originalHashes": [
    "string"
  ],
  "paymentAddress": "string",
  "paymentAmtBtc": 0,
  "paymentId": 0,
  "seedHash": "string",
  "seedId": 0,
  "stampHash": "string",
  "stampId": 0,
  "status": 0,
  "transactionId": "string"
}

```

*OpenResponse*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|expectedSubmissionTime|integer(int64)|false|none|none|
|originalHashes|[string]|false|none|none|
|paymentAddress|string|false|none|none|
|paymentAmtBtc|number(double)|false|none|none|
|paymentId|integer(int64)|false|none|none|
|seedHash|string|false|none|none|
|seedId|integer(int64)|false|none|none|
|stampHash|string|false|none|none|
|stampId|integer(int64)|false|none|none|
|status|integer(int32)|false|none|none|
|transactionId|string|false|none|none|

<h2 id="tocSstampbasicrequest">StampBasicRequest</h2>

<a id="schemastampbasicrequest"></a>

```json
{
  "emailToNotify": "string",
  "originalHashes": [
    "string"
  ]
}

```

*StampBasicRequest*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|emailToNotify|string|false|none|An optional email we will notify when your Chainstamp proof confirms in the blockchain.|
|originalHashes|[string]|false|none|An array of sha256 hashes|

<h2 id="tocSverifyitemstatus">VerifyItemStatus</h2>

<a id="schemaverifyitemstatus"></a>

```json
{
  "blockHash": "string",
  "blockNumber": 0,
  "blockTime": "2018-12-17T03:55:23Z",
  "confirmations": 0,
  "expectedSubmissionTime": 0,
  "seedHash": "string",
  "status": 0,
  "txId": "string",
  "txTime": "2018-12-17T03:55:23Z"
}

```

*VerifyItemStatus*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|blockHash|string|false|none|none|
|blockNumber|integer(int32)|false|none|none|
|blockTime|string(date-time)|false|none|none|
|confirmations|integer(int32)|false|none|none|
|expectedSubmissionTime|integer(int64)|false|none|Time in milliseconds till blockchain submission.|
|seedHash|string|false|none|none|
|status|integer(int32)|false|none|none|
|txId|string|false|none|none|
|txTime|string(date-time)|false|none|none|

<h2 id="tocSverifystatus">VerifyStatus</h2>

<a id="schemaverifystatus"></a>

```json
{
  "blockHash": "string",
  "blockNumber": 0,
  "blockTime": "2018-12-17T03:55:23Z",
  "confirmations": 0,
  "expectedSubmissionTime": 0,
  "paid": false,
  "paymentLevel": "string",
  "seedHash": "string",
  "status": 0,
  "txId": "string",
  "txTime": "2018-12-17T03:55:23Z"
}

```

*VerifyStatus*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|blockHash|string|false|none|none|
|blockNumber|integer(int32)|false|none|none|
|blockTime|string(date-time)|false|none|none|
|confirmations|integer(int32)|false|none|none|
|expectedSubmissionTime|integer(int64)|false|none|Time in milliseconds till blockchain submission.|
|paid|boolean|false|none|Indicates if we've received payment (ignore for Free/BASIC levels)|
|paymentLevel|string|false|none|The payment level made. One of "BASIC", "SIMPLE", "PRO"|
|seedHash|string|false|none|none|
|status|integer(int32)|false|none|none|
|txId|string|false|none|none|
|txTime|string(date-time)|false|none|none|

