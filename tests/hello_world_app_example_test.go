package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestHelloWorldAppExample(t *testing.T) {
	t.Parallel()

	options := &terraform.Options{
		TerraformDir: "../examples/hello-world-app",
		Vars: map[string]interface{}{
			"mysql_config": map[string]interface{}{
				"address": "mock-value-for-test",
				"port":    3306,
			},
		},
	}

	//Clean up everything at the end of the test
	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)

	albDnsName := terraform.OutputRequired(t, options, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)

	expectedStatus := 200
	expectedBody := `<h1>Hello, Petsuri</h1>
<p>DB address: mock-value-for-test</p>
<p>DB port: 3306</p>`

	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,
		expectedStatus,
		expectedBody,
		maxRetries,
		timeBetweenRetries,
	)
}
