package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAlbExample(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: "../examples/alb",
	}

	// Clean up everything at the end of the test
	defer terraform.Destroy(t, options)

	// Deploy the example
	terraform.InitAndApply(t, options)

	// Get the URL of the ALB
	albDnsName := terraform.OutputRequired(t, options, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)

	// Test that the ALB's default action is working and returns a 404
	expectedStatus := 404
	expectedBody := "404: page not found"

	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,
		expectedStatus,
		expectedBody,
		maxRetries,
		timeBetweenRetries)
}
