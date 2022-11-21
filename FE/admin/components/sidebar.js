const sidebarElement = document.querySelector('.sidebar');
sidebarElement.innerHTML = `<h2 class="sidebar__heading">ASP Company</h2> 
<ul class="sidebar__list">
    <li>
        <i class="sidebar__icon fa-solid fa-house"></i>
        <a href="#">Trang chủ</a>
    </li>
    <li>
        <i class="sidebar__icon fa-solid fa-user"></i>
        <a href="http://127.0.0.1:5500/user-management">Quản lý người dùng</a>
    </li>
    <li>
        <i class="sidebar__icon fa-brands fa-product-hunt"></i>
        <a href="http://127.0.0.1:5500/product-management">Quản lý sản phẩm</a>
    </li>
    <li>
        <i class="sidebar__icon fa-brands fa-sketch"></i>
        <a href="http://127.0.0.1:5500/category-management">Quản lý danh mục</a>
    </li>
    <li>
        <i class="sidebar__icon fa-solid fa-money-bill"></i>
        <a href="http://127.0.0.1:5500/bill-management">Quản lý hóa đơn</a>
    </li>
    <li>
        <i class="sidebar__icon fa-solid fa-comment"></i>
        <a href="http://127.0.0.1:5500/comment-management">Quản lý bình luận</a>
    </li>
</ul>   `