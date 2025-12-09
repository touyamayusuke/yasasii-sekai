import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // URLパラメータからモードを取得して初期状態を設定
    const params = new URLSearchParams(window.location.search)
    const mode = params.get('mode')
    
    if (mode === 'gentle') {
      this.applyGentleMode()
    } else {
      this.applyOriginalMode()
    }
    
    // 既存のリンクにモードパラメータを追加
    this.updateLinks(mode || 'original')
    
    // Turbo navigationをリスンしてモードを維持
    document.addEventListener('turbo:before-visit', this.handleBeforeVisit.bind(this))
    
    // フォーム送信後にモードを再適用
    document.addEventListener('turbo:submit-end', this.handleSubmitEnd.bind(this))
  }

  disconnect() {
    document.removeEventListener('turbo:before-visit', this.handleBeforeVisit.bind(this))
    document.removeEventListener('turbo:submit-end', this.handleSubmitEnd.bind(this))
  }

  handleBeforeVisit(event) {
    const params = new URLSearchParams(window.location.search)
    const mode = params.get('mode')
    
    if (mode && event.detail.url) {
      const url = new URL(event.detail.url)
      if (!url.searchParams.has('mode')) {
        url.searchParams.set('mode', mode)
        event.detail.url = url.toString()
      }
    }
  }

  handleSubmitEnd() {
    // フォーム送信後にモードを再適用（少し遅延させる）
    setTimeout(() => {
      const params = new URLSearchParams(window.location.search)
      const mode = params.get('mode')
      
      if (mode === 'gentle') {
        this.applyGentleMode()
      } else {
        this.applyOriginalMode()
      }
    }, 100)
  }

  showGentle() {
    this.applyGentleMode()
    this.updateUrlMode('gentle')
    this.updateLinks('gentle')
  }

  showOriginal() {
    this.applyOriginalMode()
    this.updateUrlMode('original')
    this.updateLinks('original')
  }

  applyGentleMode() {
    document.querySelectorAll('[data-gentle-mode-target="original"]').forEach(el => {
      el.style.display = "none"
    })
    document.querySelectorAll('[data-gentle-mode-target="gentle"]').forEach(el => {
      el.style.display = "block"
    })
    // 背景を温かい色に変更
    document.body.style.backgroundColor = "#FFF5E6"
  }

  applyOriginalMode() {
    document.querySelectorAll('[data-gentle-mode-target="original"]').forEach(el => {
      el.style.display = "block"
    })
    document.querySelectorAll('[data-gentle-mode-target="gentle"]').forEach(el => {
      el.style.display = "none"
    })
    // 背景を元の色に戻す
    document.body.style.backgroundColor = "#F3F4F6"
  }

  updateUrlMode(mode) {
    const url = new URL(window.location)
    url.searchParams.set('mode', mode)
    window.history.replaceState({}, '', url)
  }

  updateLinks(mode) {
    // 掲示板へのリンクにモードパラメータを追加
    const links = document.querySelectorAll('a[href*="/boards/"]')
    
    links.forEach(link => {
      const href = link.getAttribute('href')
      // 既にクエリパラメータがある場合とない場合を処理
      if (href.includes('?')) {
        // 既存のパラメータを更新
        const [path, query] = href.split('?')
        const params = new URLSearchParams(query)
        params.set('mode', mode)
        link.setAttribute('href', `${path}?${params.toString()}`)
      } else {
        // 新規にパラメータを追加
        link.setAttribute('href', `${href}?mode=${mode}`)
      }
    })
  }
}


