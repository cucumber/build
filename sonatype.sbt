// Sonatype credentials
credentials += Credentials("Sonatype Nexus Repository Manager", "oss.sonatype.org", "cukebot", sys.env("SONATYPE_PASSWORD"))

// GPG key to sign artifacts
credentials += Credentials("GnuPG Key ID", "gpg", "E60E1F911B996560FFB135DAF4CABFB5B89B8BE6", "ignored")
