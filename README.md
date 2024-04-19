# id-provenance
Google Cloud Function to update BigQuery ID Provenance table `htan-dcc.id_provenance.upstream_ids`

Scheduled to run daily at 0300 ET.

## Requirements
Requires access to deploy resources in the HTAN Google Cloud Project, `htan-dcc`. 

## Deploy Cloud Resources

```
terraform init
terraform plan
terraform apply
```
