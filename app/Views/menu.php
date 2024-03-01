<li class="nav-item nav-category">
            <span class="nav-link">Navigation</span>
          </li>
          <li class="nav-item menu-items">
            <a class="nav-link" href="/home/dashboard">
              <span class="menu-icon">
                <i class="mdi mdi-speedometer"></i>
              </span>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <?php  if(session()->get('level')== 'admin'){ ?>          
          <li class="nav-item menu-items">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic-user" aria-expanded="false" aria-controls="ui-basic-user">
              <span class="menu-icon">
                <i class="fa-solid fa-user"></i>
              </span>
              <span class="menu-title">User</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic-user">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"><a class="nav-link" href="<?= base_url('/pengawai')?>">Pegawai</a></li>
                <li class="nav-item"><a class="nav-link" href="<?= base_url('/peminjam')?>">Peminjam</a></li>
              </ul>
            </div>
          </li>
          <?php  }else{}?>

          <li class="nav-item menu-items">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic-buku" aria-expanded="false" aria-controls="ui-basic-buku">
              <span class="menu-icon">
                <i class="fa-solid fa-book"></i>
              </span>
              <span class="menu-title">Buku</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic-buku">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"><a class="nav-link" href="<?= base_url('/buku')?>">Daftar Buku</a></li>
                <?php  if(session()->get('level')== "admin"){ ?>
                <li class="nav-item"><a class="nav-link" href="<?= base_url('/Kategori')?>">Kategori Buku</a></li>
                <?php }?>
                <?php  if(session()->get('level')== "peminjam"){ ?>
                <li class="nav-item"><a class="nav-link" href="<?= base_url('/koleksi')?>">Koleksi Buku</a></li>
                <?php }?>
                <li class="nav-item"><a class="nav-link" href="<?= base_url('/peminjaman')?>">Peminjaman Buku</a></li>
              </ul>
            </div>
          </li>
          <?php  if(session()->get('level')!= "peminjam"){ ?>
          <li class="nav-item menu-items">
            <a class="nav-link" href="/laporan">
              <span class="menu-icon">
                <i class="fa-solid fa-file"></i>
              </span>
              <span class="menu-title">Laporan</span>
            </a>
          </li>
          <?php  }else{}?>
          <li class="nav-item menu-items">
            <a class="nav-link" href="/home/logout">
              <span class="menu-icon">
                <i class="fa-solid fa-right-from-bracket"></i>
              </span>
              <span class="menu-title">LogOut</span>
            </a>
          </li>
        </ul>
      </nav>
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
        <nav class="navbar p-0 fixed-top d-flex flex-row">
          <div class="navbar-brand-wrapper d-flex d-lg-none align-items-center justify-content-center">
            <a class="navbar-brand brand-logo-mini" href="index.html"><img src="images/logo-mini.svg" alt="logo" /></a>
          </div>
          <div class="navbar-menu-wrapper flex-grow d-flex align-items-stretch">
            <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
              <span class="mdi mdi-menu"></span>
            </button>
            <ul class="navbar-nav w-100">
              <li class="nav-item w-100">
                <form class="nav-link mt-2 mt-md-0 d-none d-lg-flex search">
                  <input type="text" class="form-control" placeholder="Search products">
                </form>
              </li>
            </ul>
            <ul class="navbar-nav navbar-nav-right">
              <li class="nav-item dropdown">
                <a class="nav-link" id="profileDropdown" href="#" data-toggle="dropdown">
                  <div class="navbar-profile">
                    <img class="img-xs rounded-circle" src="images/faces/face15.jpg" alt="">
                    <p class="mb-0 d-none d-sm-block navbar-profile-name"><?= session()->get('username')?></p>
                  </div>
                </a>
              </li>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
              <span class="mdi mdi-format-line-spacing"></span>
            </button>
          </div>
        </nav>
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
              <div class="col-12 grid-margin stretch-card">
                <div class="card corona-gradient-card">
                  

