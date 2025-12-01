<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Explora el Mundo - Agencia de Viajes</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .card:hover { transform: translateY(-5px); transition: 0.3s; }
        .mas-vendido { border: 3px solid #ff7f50; }
        .pais-img { height: 180px; object-fit: cover; border-radius: 8px; }
        .card-title span { margin-left: 5px; }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-5"><i class="fas fa-globe"></i> Explora el Mundo</h1>
    
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <%
            class Pais {
                String nombre, descripcion, imagen;
                boolean disponible, masVendido;
                Pais(String nombre, String descripcion, String imagen, boolean disponible, boolean masVendido){
                    this.nombre = nombre;
                    this.descripcion = descripcion;
                    this.imagen = imagen;
                    this.disponible = disponible;
                    this.masVendido = masVendido;
                }
            }

List<Pais> paises = new ArrayList<>();

// Europa
paises.add(new Pais("España","Historia y playas mediterráneas","https://risbelmagazine.es/wp-content/uploads/2021/08/playas-mas-bonitas-espana-Tossa-de-Mar.jpg",true,true));
paises.add(new Pais("Italia","Roma y gastronomía","https://www.barcelo.com/guia-turismo/wp-content/uploads/2024/09/ok-mercados-roma.jpg",true,true));
paises.add(new Pais("Francia","París y viñedos","https://chateauberne-vin.com/cdn/shop/articles/13_vin_ile_de_france.jpg?v=1654241841",true,true));
paises.add(new Pais("Alemania","Castillos y cultura","https://www.dsmedellin.edu.co/sites/default/files/2025-03/Imagen%20texto%20web%203.png",true,true));
paises.add(new Pais("Reino Unido","Londres y paisajes históricos","https://upload.wikimedia.org/wikipedia/commons/c/cd/London_Montage_L.jpg",true,true));
paises.add(new Pais("Grecia","Islas y gastronomía","https://www.panoramagriego.gr/wp-content/uploads/sites/5/2018/06/cuisine2.jpg",true,false));
paises.add(new Pais("Noruega","Fiordos y auroras boreales","https://tierraspolares.es/wp-content/uploads/2019/03/lofoten-septiembre-auroras-1.jpg",true,false));
paises.add(new Pais("Suiza","Montañas y lagos","https://static.wixstatic.com/media/a156b1_44fdf0c86d094e47aa3e3ee0bcd4fc13~mv2.jpg/v1/fill/w_980,h_707,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/a156b1_44fdf0c86d094e47aa3e3ee0bcd4fc13~mv2.jpg",true,false));
paises.add(new Pais("Países Bajos","Tulipanes y canales","https://cdn.tourradar.com/s3/tour/750x400/253908_64d6379400346.jpg",true,false));
paises.add(new Pais("Portugal","Playas y vino","https://mediaim.expedia.com/localexpert/2983412/d2dc85d5-7a90-4610-9160-e98dac7eb076.jpg?impolicy=resizecrop&rw=500&rh=280",true,true));

// América
paises.add(new Pais("México","Cultura maya y playas","https://media.admagazine.com/photos/618a6639938f88774ad53fda/16:9/w_2656,h_1494,c_limit/73482.jpg",true,true));
paises.add(new Pais("Brasil","Carnaval y selva amazónica","https://elmercurio.com.ec/wp-content/uploads/2020/02/2d2df429f372e99df48cfceb611c5c6888f94a40w.jpg",true,true));
paises.add(new Pais("Argentina","Tango y glaciares","https://www.tangol.com/Fotos/Tours/explorando-patagonia-argentina-completa-e-iguazu_609_201804301237207.Mobile.JPG",true,true));
paises.add(new Pais("Canadá","Naturaleza y montañas","https://res.cloudinary.com/worldpackers/image/upload/c_fill,f_auto,q_auto,w_1024/v1/guides/article_cover/gfuvmfczfyosqs1k4ema?_a=BACADKGT",true,false));
paises.add(new Pais("Estados Unidos","Ciudades y parques nacionales","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAOEKWKfkqL1KBge3GOFTPaRAdiymiRcZ2rQ&s",true,true));
paises.add(new Pais("Chile","Patagonia y desierto","https://www.autofacil.es/wp-content/uploads/2021/05/rutapatagoniachilena022-1.jpg",true,false));
paises.add(new Pais("Colombia","Café y cultura","https://vivedestinos.com/wp-content/uploads/2024/02/cafe-colombia-vive-destinos-1024x538.webp",true,true));
paises.add(new Pais("Perú","Machu Picchu y gastronomía","https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg",true,true));
paises.add(new Pais("Cuba","Playas caribeñas","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQkyzlC8MNptoKDN2-uwJnKzAS07GDsXs4A&s",true,false));
paises.add(new Pais("Costa Rica","Selva tropical","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9ZhixvSvjEtSWuPvCn3Xs2wiBN3sehWy9RA&s",true,true));

// Asia
paises.add(new Pais("Japón","Templos y ciudades modernas","https://cloudfront-us-east-1.images.arcpublishing.com/artear/PFWCA65PXBFGJL4J3TR3B4JZIE.jpeg",true,false));
paises.add(new Pais("China","Gran Muralla y ciudades futuristas","https://static.nationalgeographicla.com/files/styles/image_3200/public/nationalgeographic2709904-copia.jpg?w=1900&h=1379",true,true));
paises.add(new Pais("India","Taj Mahal y festivales","https://upload.wikimedia.org/wikipedia/commons/d/da/Taj-Mahal.jpg",true,true));
paises.add(new Pais("Tailandia","Playas y templos","https://res.cloudinary.com/worldpackers/image/upload/c_limit,f_auto,q_auto,w_1140/lhmhupgjtsp6obexf5jp",true,true));
paises.add(new Pais("Malasia","Selvas y playas","https://www.shutterstock.com/image-photo/tropical-beaches-malaysia-asia-known-260nw-1015401796.jpg",true,false));
paises.add(new Pais("Vietnam","Cultura milenaria","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6C-6E_cYP-lfmbHgu8xYHiZcRByUyTiXT3w&s",true,false));
paises.add(new Pais("Singapur","Arquitectura futurista","https://revistapersonae.com/wp-content/uploads/2021/03/Galeria_257_De-Viaje_08.jpg",true,false));
paises.add(new Pais("Corea del Sur","Tecnología y gastronomía","https://www.shutterstock.com/image-photo/korean-traditional-food-soy-sauce-260nw-2403448585.jpg",true,false));
paises.add(new Pais("Indonesia","Islas tropicales","https://res.cloudinary.com/worldpackers/image/upload/c_fill,f_auto,q_auto,w_1024/v1/guides/article_cover/jwotn3ozywfirgxh7wty?_a=BACADKGT",true,true));
paises.add(new Pais("Filipinas","Playas y cultura vibrante","https://i0.wp.com/blog.expan.pro/wp-content/uploads/2023/12/shutterstock_1568716324-scaled.jpg?resize=1000%2C600&ssl=1",true,true));

// África
paises.add(new Pais("Egipto","Pirámides y Nilo","https://upload.wikimedia.org/wikipedia/commons/e/e3/Kheops-Pyramid.jpg",true,false));
paises.add(new Pais("Sudáfrica","Safaris y vida salvaje","https://www.go2africa.com/wp-content/uploads/2022/06/shutterstock_780476683_1920X768-1920x630.jpg",true,false));
paises.add(new Pais("Marruecos","Desiertos y mercados","https://viajesmarruecos.com/blog/wp-content/uploads/2017/11/slider-marruecos-2.jpg",true,true));
paises.add(new Pais("Tanzania","Serengueti y Kilimanjaro","https://ecoglobalexpeditions.com/wp-content/uploads/2017/07/kilimanjaro2-1.jpg",true,false));
paises.add(new Pais("Kenia","Safaris y naturaleza","https://losviajesdesofia.com/wp-content/uploads/parques-naturales-kenia.jpg",true,true));
paises.add(new Pais("Nigeria","Ciudades modernas","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKtn_0S1PgIVlc7Os_CVi4tFMX9tfNqyAMAg&s",true,false));
paises.add(new Pais("Senegal","Playas africanas","https://planesconduende.com/wp-content/uploads/2024/10/riu-baobab-pointe-sarene-1024x535.jpg",true,false));
paises.add(new Pais("Etiopía","Paisajes montañosos","https://thumbs.dreamstime.com/b/paisaje-monta%C3%B1oso-con-ca%C3%B1%C3%B3n-etiop%C3%ADa-hermoso-puente-lecho-seco-de-r%C3%ADo-regi%C3%B3n-somal%C3%AD-natural-%C3%A1frica-168718424.jpg",true,false));
paises.add(new Pais("Mali","Historia y desiertos","https://s.france24.com/media/display/5135c502-f248-11e8-8cc3-005056a964fe/w:1280/p:16x9/mali.jpg",true,false));
paises.add(new Pais("Madagascar","Naturaleza única","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCTZF_D8vSnlLXok4BD7zeZNgTCd7dZPFJTA&s",true,false));

// Oceanía
paises.add(new Pais("Australia","Playas y fauna","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBBxLdO_stCYBSGNP6SAY5mnwCtp5k9h8mVw&s",true,false));
paises.add(new Pais("Nueva Zelanda","Paisajes naturales","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXbaltpeXngfH81cN8pGty14q4LrcFSwwE6A&s",true,false));
paises.add(new Pais("Fiyi","Islas tropicales","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkNHSEwiuPD8M8nO2AYuzfnA0dmF-8jjP2pQ&s",true,false));
paises.add(new Pais("Papúa Nueva Guinea","Naturaleza y tribus","https://iwgia.org/images/countries/indonesia1.jpg",true,false));
paises.add(new Pais("Samoa","Playas polinesias","https://a.travel-assets.com/findyours-php/viewfinder/images/res70/61000/61991-Samoa.jpg",true,false));

// Continente Antártida
paises.add(new Pais("Antártida","Exploración de glaciares","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6a348q5qD8yvglN9vRYSm41beyT16Vkwn6A&s",false,false));

            // Renderizar tarjetas
            for(Pais p : paises) {
        %>
        <div class="col">
            <div class="card h-100 shadow-sm <%= p.masVendido ? "mas-vendido" : "" %>">
                <img src="<%= p.imagen %>" class="card-img-top pais-img" alt="<%= p.nombre %>">
                <div class="card-body">
                    <h5 class="card-title"><%= p.nombre %> 
                        <%= p.masVendido ? "<span class='badge bg-warning'>Más Vendido</span>" : "" %>
                    </h5>
                    <p class="card-text"><%= p.descripcion %></p>
                    <p class="card-text">
                        <strong>Disponibilidad: </strong>
                        <%= p.disponible ? "Disponible" : "No Disponible" %>
                    </p>
                    <% if(p.disponible) { %>
                        <a href="reservas?action=nuevo&pais=<%=p.nombre%>" class="btn btn-success w-100">Reservar</a>
                    <% } else { %>
                        <button class="btn btn-secondary w-100" disabled>No Disponible</button>
                    <% } %>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>