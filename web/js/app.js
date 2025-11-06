// Main Application Logic for ElectroMart Hub
class ElectroMartApp {
    constructor() {
        this.currentUser = null;
        this.currentPage = 'login';
        this.categories = [];
        this.products = [];
        this.cart = [];
        this.init();
    }

    init() {
        this.checkAuthStatus();
        this.bindEvents();
        this.loadCategories();
        this.loadFeaturedProducts();
    }

    checkAuthStatus() {
        // Check if user is logged in from cookie/session
        const userData = this.getCookie('user_session');
        if (userData) {
            this.currentUser = JSON.parse(userData);
            this.showPage('home');
        }
    }

    bindEvents() {
        // Search functionality
        document.getElementById('search-btn').addEventListener('click', () => {
            this.handleSearch();
        });

        document.getElementById('search-input').addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                this.handleSearch();
            }
        });

        // Navigation events are handled in navigation component
    }

    async loadCategories() {
        try {
            const response = await this.apiCall('/api/categories', 'GET');
            this.categories = response.data;
            this.renderCategories();
        } catch (error) {
            console.error('Error loading categories:', error);
        }
    }

    async loadFeaturedProducts() {
        try {
            const response = await this.apiCall('/api/products/featured', 'GET');
            this.products = response.data;
            this.renderFeaturedProducts();
        } catch (error) {
            console.error('Error loading featured products:', error);
        }
    }

    async loadProductsByCategory(categoryId) {
        try {
            const response = await this.apiCall(`/api/products/category/${categoryId}`, 'GET');
            this.products = response.data;
            this.renderProducts(`Sản phẩm: ${this.categories.find(cat => cat.id === categoryId)?.name || ''}`);
            this.showPage('products');
        } catch (error) {
            console.error('Error loading products by category:', error);
        }
    }

    async handleSearch() {
        const query = document.getElementById('search-input').value.trim();
        if (!query) return;

        try {
            const response = await this.apiCall(`/api/products/search?q=${encodeURIComponent(query)}`, 'GET');
            this.products = response.data;
            this.renderProducts(`Kết quả tìm kiếm: "${query}"`);
            this.showPage('products');
        } catch (error) {
            console.error('Error searching products:', error);
        }
    }

    renderCategories() {
        const container = document.getElementById('categories');
        container.innerHTML = this.categories.map(category => `
            <div class="category-card bg-white rounded-xl shadow-md p-6 text-center cursor-pointer hover:shadow-lg transition product-card"
                 onclick="app.loadProductsByCategory(${category.id})">
                <div class="w-16 h-16 mx-auto mb-4 bg-primary-100 rounded-full flex items-center justify-center">
                    <i data-feather="${category.icon || 'box'}"></i>
                </div>
                <h3 class="font-semibold text-gray-800">${category.name}</h3>
                <p class="text-sm text-gray-600 mt-2">${category.product_count} sản phẩm</p>
            </div>
        `).join('');
        feather.replace();
    }

    renderFeaturedProducts() {
        const container = document.getElementById('featured-products');
        container.innerHTML = this.products.map(product => `
            <div class="product-card bg-white rounded-xl shadow-md overflow-hidden">
                <div class="h-48 bg-gray-200 flex items-center justify-center">
                    <img src="${product.image_url || 'http://static.photos/technology/320x240/' + (Math.floor(Math.random() * 100) + 1}" 
                     alt="${product.name}" class="w-full h-full object-cover">
                </div>
                <div class="p-4">
                    <h3 class="font-semibold text-gray-800 mb-2">${product.name}</h3>
                    <p class="text-primary-600 font-bold text-lg mb-3">${this.formatPrice(product.price)}₫</p>
                    <div class="flex justify-between items-center">
                        <span class="text-sm text-gray-600">Đã bán: ${product.sold_count}</span>
                        <button onclick="app.addToCart(${product.id})" 
                                class="bg-primary-500 text-white px-4 py-2 rounded-lg hover:bg-primary-600 transition text-sm">
                            Thêm vào giỏ
                        </button>
                    </div>
                </div>
            </div>
        `).join('');
    }

    renderProducts(title) {
        document.getElementById('products-title').textContent = title;
        const container = document.getElementById('products-list');
        container.innerHTML = this.products.map(product => `
            <div class="product-card bg-white rounded-xl shadow-md overflow-hidden">
                <div class="h-56 bg-gray-200 flex items-center justify-center">
                    <img src="${product.image_url || 'http://static.photos/technology/320x240/' + (Math.floor(Math.random() * 100) + 1}" 
                     alt="${product.name}" class="w-full h-full object-cover">
                </div>
                <div class="p-4">
                    <h3 class="font-semibold text-gray-800 mb-2">${product.name}</h3>
                    <p class="text-gray-600 text-sm mb-3 line-clamp-2">${product.description || 'Sản phẩm chất lượng cao'}</p>
                    <div class="flex justify-between items-center mb-3">
                        <span class="text-primary-600 font-bold">${this.formatPrice(product.price)}₫</span>
                        ${product.original_price ? `
                            <span class="text-gray-400 text-sm line-through">${this.formatPrice(product.original_price)}₫</span>
                        ` : ''}
                    </div>
                    <button onclick="app.addToCart(${product.id})" 
                            class="w-full bg-primary-500 text-white py-2 rounded-lg hover:bg-primary-600 transition">
                        Thêm vào giỏ
                    </button>
                </div>
            </div>
        `).join('');
    }

    showPage(pageName) {
        // Hide all pages
        document.querySelectorAll('section[id$="-page"]').forEach(page => {
            page.classList.add('hidden');
        });

        // Show selected page
        document.getElementById(`${pageName}-page`).classList.remove('hidden');
        this.currentPage = pageName;

        // Update navigation active state
        const nav = document.querySelector('custom-navigation');
        if (nav && nav.shadowRoot) {
            const navItems = nav.shadowRoot.querySelectorAll('.nav-item');
            navItems.forEach(item => {
                item.classList.remove('text-primary-600', 'border-primary-600');
                if (item.getAttribute('data-page') === pageName) {
                    item.classList.add('text-primary-600', 'border-primary-600');
                }
            });
        }
    }

    addToCart(productId) {
        const product = this.products.find(p => p.id === productId);
        if (!product) return;

        const existingItem = this.cart.find(item => item.id === productId);
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            this.cart.push({
                ...product,
                quantity: 1
            });
        }

        this.updateCart();
        this.showToast('Đã thêm sản phẩm vào giỏ hàng!', 'success');
    }

    updateCart() {
        // Update cart in localStorage
        localStorage.setItem('electromart_cart', JSON.stringify(this.cart));
        
        // Update cart badge
        const cartBadge = document.querySelector('custom-navigation').shadowRoot.querySelector('#cart-badge');
        if (cartBadge) {
            const totalItems = this.cart.reduce((sum, item) => sum + item.quantity, 0);
            cartBadge.textContent = totalItems;
            cartBadge.classList.toggle('hidden', totalItems === 0);
        }
    }

    formatPrice(price) {
        return new Intl.NumberFormat('vi-VN').format(price);
    }

    getCookie(name) {
        const value = `; ${document.cookie}`;
        const parts = value.split(`; ${name}=`);
        if (parts.length === 2) return parts.pop().split(';').shift();
    }

    setCookie(name, value, days) {
        const expires = new Date(Date.now() + days * 864e5).toUTCString();
        document.cookie = `${name}=${value}; expires=${expires}; path=/`;
    }

    async apiCall(url, method, data = null) {
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': this.currentUser ? `Bearer ${this.currentUser.token}` : ''
        };

        if (data) {
            options.body = JSON.stringify(data);
        }

        const response = await fetch(url, options);
        if (!response.ok) {
            throw new Error(`API call failed: ${response.statusText}`);
        }

        return await response.json();
    }

    showToast(message, type = 'info') {
        // Create toast element
        const toast = document.createElement('div');
        toast.className = `fixed top-4 right-4 z-50 px-6 py-3 rounded-lg shadow-lg text-white ${
                type === 'success' ? 'bg-green-500' : 
                type === 'error' ? 'bg-red-500' : 
                'bg-blue-500'
            } fade-in`;
        toast.textContent = message;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.remove();
        }, 3000);
    }
}

// Initialize the app
const app = new ElectroMartApp();