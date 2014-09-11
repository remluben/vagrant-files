<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/normalize/3.0.1/normalize.min.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <style type="text/css">
            body { margin-top: 20px }
        </style>
        <script src="//cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">

                    <div class="alert alert-info" role="alert">
                        Congratulations! Your vagrant VM is up and running with 
                        <ul>
                            <li>the latest version of PHP 5.*</li>
                            <li>the Apache webserver</li>
                            <li>a MYSQL database <i>development</i> with username and password <i>root</i></li>
                        </ul>
                    </div>
                    <div>
                        <?php phpinfo(); ?>
                    </div>
                </div>
            </div>
        </div>

        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    </body>
</html>
