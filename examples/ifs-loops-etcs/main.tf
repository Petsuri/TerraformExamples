variable "names" {
  description = "List of names"
  type        = list(string)
  default     = ["Petri", "Mei", "Sofia"]
}

output "upper_names" {
  value = [for name in var.names : upper(name)]
}

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo     = "hero"
    trinity = "useless chick"
    morheus = "mentor"
  }
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "map_bios" {
  value = { for name, role in var.hero_thousand_faces : name => upper(role) }
}

output "for_directive" {
  value = <<EOF

  %{~for name in var.names~} 
    ${name}
  %{~endfor~}
  EOF
}

variable "name" {
  description = "A name to render"
  type        = string
}

output "if_else_directive" {
  value = "Hello, %{if var.name != ""}${var.name}%{else} (unnamed) %{endif}"
}

