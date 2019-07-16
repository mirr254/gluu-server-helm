apiVersion: batch/v1
kind: Job
metadata:
  name: {{ template "gluu.fullname" . }}-config-init
spec:
  template:
    metadata:
      labels: 
        app: {{ template "gluu.fullname" . }}-config-init
    spec:
      restartPolicy: Never
      volumes:
        - name: {{ template "gluu.fullname" . }}-config
          persistentVolumeClaim: 
            claimName: {{ template "gluu.fullname" . }}-config-volume-claim
      containers:
        - name: {{ template "gluu.fullname" . }}-config-init
          image: gluufederation/config-init:3.1.6_02
          volumeMounts:
            - mountPath: /opt/config-init/db/
              name: {{ template "gluu.fullname" . }}-config
              subPath: db
          envFrom:
          - configMapRef:        
              name: {{ template "gluu.fullname" . }}-config-cm
          # we define args here. The default command defined in the container will use the new args
          args: ["generate", "--admin-pw", "$(ADMIN_PW)", "--email", "$(EMAIL)", "--domain", "$(DOMAIN)", "--org-name", "$(ORG_NAME)", "--country-code", "$(COUNTRY_CODE)", "--state", "$(STATE)", "--city", "$(CITY)", "--ldap-type", "$(LDAP_TYPE)"]

