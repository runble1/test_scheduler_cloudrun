resource "google_cloud_scheduler_job" "job" {
  name             = "test-job"
  description      = "test http job"
  schedule         = "*/8 * * * *"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "GET"
    uri         = google_cloud_run_service.default.status[0].url
    #body        = base64encode("{\"foo\":\"bar\"}")

    oidc_token {
      service_account_email = google_service_account.run_invoker.email
    }
  }
}