#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <iterator>

class l_system {
protected:
	std::map<char, std::string> ruleMap;
	std::vector<char> init_word;
	std::vector<char> generated_word;
	unsigned int iterationLimit;
	float angle;
	float length;

	bool checkElement(char test) {
		std::map<char, std::string>::iterator it = ruleMap.find(test);
		return it != ruleMap.end();
	}

public:
	l_system() {}

	l_system(std::string init_string) {
		std::copy(init_string.begin(), init_string.end(), std::back_inserter(init_word));
	}

	void setAngle(float newAngle) {
		angle = newAngle;
	}
	void setLength(float newLength) {
		length = newLength;
	}

	void setInitWord(std::string init_string) {
		std::copy(init_string.begin(), init_string.end(), std::back_inserter(init_word));
	}

	bool addRule(char key, std::string effect) {
		ruleMap.insert(std::pair<char, std::string>(key, effect));
		return true;
	}
	
	bool iterate(unsigned int currentDepth, std::string &rule) {
		for (unsigned int i = 0; i < rule.size(); i++) {
			if (checkElement(rule[i]) && currentDepth <= iterationLimit) iterate(currentDepth + 1, ruleMap[rule[i]]);
			else generated_word.push_back(rule[i]);
		}
		return true;
	}

	bool iterate(unsigned int limit) {
		iterationLimit = limit;
		for (unsigned int i = 0; i < init_word.size(); i++) {
			if (checkElement(init_word[i])) iterate(1, ruleMap[init_word[i]]);
			else generated_word.push_back(init_word[i]);
		}
		return true;
	}

	bool save(std::string filename) {
		std::fstream file;
		file.open(filename, std::ios::out);
		if (!file.is_open()) {
			std::cout << "Problem z otwarciem pliku" << std::endl;
			return false;
		}
		file.clear();


		file << angle << "\n";
		file << length << "\n";
		for (int i = 0; i < generated_word.size(); i++) file << generated_word[i];
		file.close();
		return true;
	}

	void print(std::ostream &output) {
		for (int i = 0; i < generated_word.size(); i++) {
			output << generated_word[i];
		}
		return;
	}

};

int main() {
	l_system sys;

	std::fstream plik;
	plik.open("lsystemconfig.txt", std::ios::in);

	if (!plik.is_open()) {
		plik.close();
		std::cout << "Brak pliku lsystemconfig" << std::endl;
	}
	else {
		std::cout << "Znaleziono plik lsystemconfig" << std::endl;

		unsigned int limit;
		char key;
		std::string init_word, rule;
		float length, angle;
		

		plik >> init_word;
		plik >> angle;
		plik >> length;
		plik >> limit;

		std::cout << angle << std::endl;

		sys.setInitWord(init_word);
		sys.setAngle(angle);
		sys.setLength(length);

		while (!plik.eof()) {
			plik >> key >> rule;
			sys.addRule(key, rule);
		}

		plik.close();


		sys.iterate(limit);

		sys.save("l-system.txt");

		std::cout << "Plik zapisano" << std::endl;
		//sys.print(std::cout);
		std::cout << std::endl;
	}
	//int wait; std::cin >> wait;
	return 0;
}