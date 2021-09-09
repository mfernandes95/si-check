#!/bin/bash

SSL_URL=https://docs.nestjs.com/
URL=http://docs.nestjs.com/

curl -I $SSL_URL > curl-response.txt
echo "-----------------------RESPONSE-----------------------------"
cat curl-response.txt
echo "------------------------------------------------------------"

echo "Outdated Libraries"
if grep -n "X-Powered-By:" curl-response.txt; then
    echo "ERROR: Founded"
else
    echo "SUCCESS: Not Founded"
fi
echo "------------------------------------------------------------"

echo "HTTPS"
response=$(
    curl $URL \
        --write-out %{http_code} \
        --silent \
        --output /dev/null \
)

if [ $response -eq 301 ]
then
    echo "SUCCESS: SSL verification OK"
else
    echo "ERROR: Expect 301 but received 200"
fi
echo "------------------------------------------------------------"

echo "HTTP Strict Transport Security"
if grep -n "strict-transport-security: max-age=31536000" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "X-Content-Type-Options"
if grep -n "x-content-type-options:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "HTTP Public Key Pinning"
if grep -n "public-key-pins:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "Content Security Policy"
if grep -n "content-security-policy:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "Permitted-Cross-Domain-Policies"
if grep -n "x-permitted-cross-domain-polices:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "Referrer-Policy"
if grep -n "referrer-policy:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "Expect-CT"
if grep -n "Expect-CT:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "Feature-Policy"
if grep -n "Feature-Policy:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

echo "Error Handling"
if grep -n "server:" curl-response.txt; then
    echo "SUCCESS: Founded"
else
    echo "ERROR: Not Founded"
fi
echo "------------------------------------------------------------"

#Remove TXT
rm -rf curl-response.txt

