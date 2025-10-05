import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]

  toggle() {
    this.sidebarTarget.classList.toggle('hidden')
    this.sidebarTarget.classList.toggle('flex')

    // Make it fixed on mobile when visible
    if (!this.sidebarTarget.classList.contains('hidden')) {
      this.sidebarTarget.classList.add('fixed', 'inset-0', 'z-40', 'lg:static', 'lg:z-auto')
    } else {
      this.sidebarTarget.classList.remove('fixed', 'inset-0', 'z-40')
    }
  }
}
