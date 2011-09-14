<div id="HighGradeUniversalCentury" class="gunplaype">
	<div class="bigBox">
		<h1 id="mostImportantProducts_Title">High Grade Universal Century</h1>
		<div>
			<img src="/images/hguc.jpg?1314865160" alt="Hguc">
			<p>
				Sono model kit prodotti a partire dal 1999 tratti dalla serie Universal Century In scala 1/144 , facili da assemblare non richiedono necessariamente l' uso di colla o colore per l' assemblaggio
			</p>
		</div>
	</div>
	
		<?php
		$con = mysql_connect("62.149.150.87", "Sql235594", "dddbbbd5");
		if(!$con) {
			die('Could not connect: ' . mysql_error());
		}

		mysql_select_db("Sql235594_1", $con);
		$sql = "SELECT `WebOggetti`.`ProdCode`, `WebOggetti`.`Description`, `WebOggetti`.`CategoryDesc`, `WebOggetti`.`CustomT2Desc`, `WebOggetti`.`IdProduct`, `WebOggetti`.`CustomT2ID`, `WebOggetti`.`ProductCategoriesAndFathers`, `Foto`.`IdTipoFoto`, `Foto`.`Nomefile`, `WebOggetti`.`QTotMagazzino`, `WebOggetti`.`PrezzoListinoUfficiale`, `WebOggetti`.`IdLanguage` FROM `WebOggetti`, `FotoLinks`, `Foto` WHERE `WebOggetti`.`IdProduct` = `FotoLinks`.`IdArticolo` AND `Foto`.`ID` = `FotoLinks`.`IdFoto` AND `WebOggetti`.`CustomT2ID` = 70 AND `Foto`.`IdTipoFoto` = 1 AND `WebOggetti`.`IdLanguage` = 1 ORDER BY `WebOggetti`.`CategoryDesc` DESC";
		$result = mysql_query($sql);

		while($row = mysql_fetch_array($result)) {
			echo "<div class=\"resultBox\">";
			echo "<a class=\"imageLink\" href=\"DOLLS-PELUCHES_APE-MAYA-15cm-Plush.1.10.96.gp.17241.-1.uw.aspx\">";
			echo "<img border =\"0\" src=\"http://www.starshopbs.com/files/Madhouse_Files/Foto/".$row['Nomefile']."\" alt=\"".$row['Description']."\" border=\"0\">";
			echo "</a>";
			echo "</div>";
		
		}

		mysql_close($con);
	?>

</div>

<a class="imageLink" href="DOLLS-PELUCHES_APE-MAYA-15cm-Plush.1.10.96.gp.17241.-1.uw.aspx">
<img border="0" alt="APE MAYA - 15cm. Plush" src="files/Madhouse_Files/Foto/17241_7777.JPG">
</a>
