# docker_cleanup
Repository for storing different scripts that can be used for docker maintenance (mainly garbage collecting).

Scripts can be used as standalone, one time job or as cron job.

Also they can be used via ansible. Just put those files into the files directory (within a role structure) and use it through "script" module:

For example:
```
tasks/main.yml
---
- name: Search for obsolete images to remove
  script: show_old_img.sh 1
  register: c_result
  changed_when: "c_result.stdout!=''"
 
- name: Show obsolete images
  debug: "var=c_result.stdout_lines"
  when: c_result.stdout != ""
```
