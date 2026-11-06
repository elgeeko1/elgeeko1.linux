# elgeeko1.engineering.kicad

Installs KiCad 9 from the KiCad releases PPA.

## Features

- Adds the `kicad/kicad-9.0-releases` PPA and installs `kicad`.

## Requirements

- The [collection requirements](../../README.md#requirements).
- Ubuntu hosts only.

## Role variables

<!-- BEGIN_ANSIBLE_DOCS -->

None.

<!-- END_ANSIBLE_DOCS -->

## Example playbook

```yaml
- name: Configure workstations
  hosts: workstations
  roles:
    - role: elgeeko1.engineering.kicad
```

## License

MIT. See [LICENSE](LICENSE).
