import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["original", "gentle", "originalBtn", "gentleBtn"]

  showOriginal() {
    this.originalTarget.classList.remove("hidden")
    this.gentleTarget.classList.add("hidden")
    this.originalBtnTarget.classList.add("bg-indigo-600", "text-white", "shadow")
    this.originalBtnTarget.classList.remove("border", "border-slate-200", "text-slate-700")
    this.gentleBtnTarget.classList.remove("bg-indigo-600", "text-white", "shadow")
    this.gentleBtnTarget.classList.add("border", "border-slate-200", "text-slate-700")
  }

  showGentle() {
    this.originalTarget.classList.add("hidden")
    this.gentleTarget.classList.remove("hidden")
    this.gentleBtnTarget.classList.add("bg-indigo-600", "text-white", "shadow")
    this.gentleBtnTarget.classList.remove("border", "border-slate-200", "text-slate-700")
    this.originalBtnTarget.classList.remove("bg-indigo-600", "text-white", "shadow")
    this.originalBtnTarget.classList.add("border", "border-slate-200", "text-slate-700")
  }
}
