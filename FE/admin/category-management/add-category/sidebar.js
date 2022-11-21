const sidebarElement = document.querySelector('.sidebar');
sidebarElement.innerHTML = `<h2 class="sidebar__heading">ASP Company</h2> 
<ul class="sidebar__list">
    <li>
        <i class="sidebar__icon fa-solid fa-house"></i>
        <a href="#">Trang chủ</a>
    </li>
    <li>
        <i class="sidebar__icon fa-solid fa-user"></i>
        <a href="#">Quản lý người dùng</a>
    </li>
    <li>
        <i class="sidebar__icon fa-brands fa-product-hunt"></i>
        <a href="../index.html">Quản lý sản phẩm</a>
    </li>
    <li>
        <i class="sidebar__icon fa-brands fa-sketch"></i>
        <a href="#">Quản lý danh mục</a>
    </li>
    <li>
        <i class="sidebar__icon fa-solid fa-money-bill"></i>
        <a href="#">Quản lý hóa đơn</a>
    </li>
    <li>
        <i class="sidebar__icon fa-solid fa-comment"></i>
        <a href="#">Quản lý bình luận</a>
    </li>
</ul>   `