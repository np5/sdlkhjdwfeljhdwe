resource "zentral_munki_script_check" "mcs-auditing-audit_acls_files_configure" {
  name = "[mSCP] - Auditing - Configure Audit Log Files to Not Contain Access Control Lists"
  description = trimspace(<<EODESC
The audit log files _MUST_ not contain access control lists (ACLs).

This rule ensures that audit information and audit files are configured to be readable and writable only by system administrators, thereby preventing unauthorized access, modification, and deletion of files.
EODESC
  )
  type = "ZSH_INT"
  source = trimspace(<<EOSRC
/bin/ls -le $(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}') | /usr/bin/awk '{print $1}' | /usr/bin/grep -c ":"
EOSRC
  )
  expected_result = "0"
  arch_amd64      = true
  arch_arm64      = true
  min_os_version  = "14"
  max_os_version  = "15"
}
