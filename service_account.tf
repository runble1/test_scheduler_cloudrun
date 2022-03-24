resource "google_service_account" "run_invoker" {
  project      = var.project
  account_id   = "cloud-run-invoker-sa"
  display_name = "Cloud Run Invoker Service Account"
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.run_invoker.email}"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "policy" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.admin.policy_data
}