import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtCharts 2.3
import QtQuick.Particles 2.12
import QtQuick.Window 2.12

Page{ // статистика команды
    id : pageTeamStat
    background: Item{
        opacity: 0.2
    }
    ChartView {
	anchors.fill: parent
	//theme: ChartView.ChartThemeBrownSand
	//antialiasing: true
	BarSeries {
	    id: mySeries
	    axisX: BarCategoryAxis { categories: ["%усп.тст.", "%усп.сб.", "задачи", "комм", "%покр."] }
	    BarSet { label: "Бек-разработка"; values: [80, 60, 50, 90, 80] }
	}
    }
}
